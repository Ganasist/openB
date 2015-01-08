class MessagesController < ApplicationController
  before_filter :get_messageable, only: [:new, :create]
  def new
    @message = Message.new
    @user = User.find(params[:user_id])
  end

  def create
    @message = Message.new(message_params)
    @message.messageable = User.find(params[:user_id])
    if current_member.send_message(@message)
      redirect_to current_member, notice: 'Message sent to XYZ'
    else
      redirect_to current_member, alert: 'Message could not be sent'
    end
  end

  def index
    @messages = current_member.received_messages
  end

  def show
    @message = Message.find(params[:id])
    @messages = @message.conversation
  end

  def reply
    @message = Message.find(params[:message_id])
    puts 'HELLOS?'
    if current_member.reply_to(@message, params[:topic], params[:body])
      redirect_to message_path(@message), notice: 'Reply sent!'
    else
      redirect_to :new, alert: "Reply could not be sent #{ @message.errors.full_messages.to_sentence }"
    end
  end

  private
    def get_messageable
      @messageable = params[:messageable].classify.constantize.find(messageable_id)
    end

    def messageable_id
      params[(params[:messageable].singularize + "_id").to_sym]
    end

    def message_params
      params.require(:message).permit(:received_messageable_id, :received_messageable_type, :topic, :body)
    end
end
