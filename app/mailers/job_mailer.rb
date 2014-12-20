class JobMailer < ActionMailer::Base
  default from: 'noreply@openbid.com'
  before_action :set_logo

  def create(job)
    @job = job
    @user = job.user
    @contractors = Contractor.near(job, 100).relevant_categories(job.categories)
    @emails = @contractors.map(&:email)
    mail(to: @user.email, bcc: @emails,
    subject: "New job posted nearby: '#{ @job.title }': #{ @job.categories.to_sentence }")
  end

  def update(job)
    @job = job
    @user = job.user
    @contractors = Contractor.near(job, 100).relevant_categories(job.categories)
    @emails = @contractors.map(&:email)
    mail(to: @user.email, bcc: @emails,
    subject: "Job post '#{ @job.title }' has been updated.")
  end

  private
    def set_logo
      attachments.inline['logo.png'] = File.read("#{ Rails.root.to_s + '/app/assets/images/logo.png' }")
    end
end
