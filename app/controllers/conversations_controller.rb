class ConversationsController < ApplicationController
  before_filter :deny_to_visitors
  helper_method :mailbox, :conversation

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

    def deny_to_visitors
      redirect_to root_path unless member_signed_in?
    end
end
