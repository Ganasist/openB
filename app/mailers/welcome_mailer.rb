class WelcomeMailer < ApplicationMailer

  def contractor_welcome(contractor)
    @contractor = contractor
    mail(to: @contractor.email,
    subject: 'OPENBID Registration Confirmation')
  end

  def user_welcome(user)
    @user = user
    mail(to: @user.email,
    subject: 'OPENBID Registration Confirmation')
  end
end
