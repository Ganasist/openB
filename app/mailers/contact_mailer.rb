class ContactMailer < ActionMailer::Base

  def contact_email(email, comment)
    @email  = email
    @comment = comment
    mail(to: 'contact@openbid.com', from: @email, subject: "New message from #{ @email }" )
  end
end
