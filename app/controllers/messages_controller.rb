class MessagesController < ApplicationController

  def new
    @message = ActsAsMessageable::Message.new
  end

  def create

  end

  def index

  end

  def show

  end

  def reply

  end
end
