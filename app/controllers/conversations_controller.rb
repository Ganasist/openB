class ConversationsController < ApplicationController  
  helper_method :mailbox, :conversation
  before_filter :authenticate_member
  before_filter :unread_count

  def index   
    @conversations ||= current_member.mailbox.inbox.all
    @page = "inbox"    
  end
  
  def sentbox
    @conversations ||= current_member.mailbox.sentbox.all
    @page = "sentbox"    
    render :index
  end
  
  def trashbin     
    @conversations ||= current_member.mailbox.trash.all
    @page = "trashbin"    
    render :index   
  end
  
  def new
    if params[:user].present?
      user = User.find(params[:user])
      @recipient_emails = [user.email]
    elsif params[:contractor].present?
      contractor = Contractor.find(params[:contractor])
      @recipient_emails = [contractor.email]
    end
  end

  def create        
    recipient_emails = conversation_params(:recipients).split(',')    
    if current_member.user?
      recipients = Contractor.where(email: recipient_emails).all
    else
      recipients = User.where(email: recipient_emails).all
    end
    conversation = current_member.send_message(recipients, *conversation_params(:body, :subject)).conversation
    redirect_to conversation_path(conversation)
  end
  
  def show
    conversation.mark_as_read(current_member)
  end  

  def reply
    current_member.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_member)
    redirect_to :back
  end

  def untrash
    conversation.untrash(current_member)
    redirect_to :back
  end
  
  def empty_trash
    current_member.mailbox.trash.each do |conversation|
      conversation.receipts_for(current_member).update_all(:deleted => true)
    end
    redirect_to :conversations
  end

  private
    def authenticate_member
      unless member_signed_in?
        redirect_to new_user_registration_path, notice: 'You have to sign up or sign in to access that page.'
      end
    end
    
    def unread_count
      @count = current_member.mailbox.receipts.where(is_read: false).count
    end

    def mailbox
      @mailbox ||= current_member.mailbox
    end

    def conversation
      @conversation ||= mailbox.conversations.find(params[:id])
    end

    def conversation_params(*keys)
      fetch_params(:conversation, *keys)
    end

    def message_params(*keys)
      fetch_params(:message, *keys)
    end

    def fetch_params(key, *subkeys)
      params[key].instance_eval do
        case subkeys.size
        when 0 then self
        when 1 then self[subkeys.first]
        else subkeys.map{|k| self[k] }
        end
      end
    end    
end
