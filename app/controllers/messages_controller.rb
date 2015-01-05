class MessagesController < ApplicationController

  # GET /messages/new
  def new
    @member = Contractor.find(222)
    @message = current_user.messages.new
  end

  # POST /messages/create
  def create
    @recipient = User.find(params[:user])
    current_user.send_message(@recipient, params[:body], params[:subject])
    redirect_to :conversations, notice: 'Message has been sent!'
  end
end
