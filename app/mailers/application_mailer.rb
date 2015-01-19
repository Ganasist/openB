class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@openbid.contractors'
  before_action :set_logo

  private
    def set_logo
      attachments.inline['logo.png'] = File.read("#{ Rails.root.to_s + '/app/assets/images/logo.png' }")
    end
end
