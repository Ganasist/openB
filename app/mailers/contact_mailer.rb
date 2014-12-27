class ContactMailer < ApplicationMailer

  def contact_email(email, comment)
    @email  = email
    @comment = comment
    mail(to: 'lance@openbid.contractors', from: @email, subject: "New message from #{ @email }" )
  end
  
end
