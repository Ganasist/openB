class ContactsController < ApplicationController
  # before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      ContactMailer.delay(retry: false).contact_email(@contact.email, @contact.comment)
      redirect_to root_path, notice: 'Your message has been sent. Thank you for your feedback.'
    else
      render 'new'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:email, :contact)
    end
end