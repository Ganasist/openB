class ContactsController < ApplicationController
  # before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      ContactMailer.delay(retry: false).contact_email(@contact.email, @contact.user, @contact.comment)
      redirect_to :back, notice: 'Your contact is appreciated!'
    else
      render 'new'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:contact)
    end
end