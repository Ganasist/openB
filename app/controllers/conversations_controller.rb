class ConversationsController < ApplicationController
  # before_filter :authenticate_user!
  helper_method :mailbox, :conversation
  before_filter :authenticate_member

  def index
    current_member.mailbox.conversations
  end

  def create
    recipient_emails = conversation_params(:recipients).split(',')
    recipients = User.where(email: recipient_emails).all

    conversation = current_member.send_message(recipients, *conversation_params(:body, :subject)).conversation

    redirect_to conversation_path(conversation)
  end

  def reply
    current_member.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation_path(conversation)
  end

  def trash
    conversation.move_to_trash(current_member)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_member)
    redirect_to :conversations
  end

  private
    def authenticate_member
      unless member_signed_in?
        redirect_to new_user_registration_path, notice: 'You have to sign up or sign in to access that page.'
      end
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
