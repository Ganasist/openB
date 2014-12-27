class WelcomeMailer < ApplicationMailer
  
  def contractor_welcome(contractor)
    @contractor = contractor
    mail(to: @contractor.email,
    subject: 'Welcome to Openbid! Find nearby jobs today.')
  end

  def user_welcome(user)
    @user = user
    mail(to: @user.email,
    subject: 'Welcome to Openbid! Find local contractors today.')
  end

end
