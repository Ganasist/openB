class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@openbid.contractors'
  before_action :set_logo

  private
    def set_logo
      attachments.inline['logo.png'] = File.read("#{ Rails.root.to_s + '/app/assets/images/logo.png' }")
    end
end
