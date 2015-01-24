class JobMailer < ApplicationMailer

  def create(job)
    set_defaults(job)
    # @job = job
    # @user = job.user
    # @contractors = Contractor.near(job, 100).relevant_categories(job.categories)
    # @emails = @contractors.map(&:email)
    mail(to: @user.email,
        bcc: @emails,
    subject: "New job posted nearby: '#{ @job.title }': #{ @job.categories.to_sentence }")
  end

  def update(job)
    set_defaults(job)
    # @job = job
    # @user = job.user
    # @contractors = Contractor.near(job, 100).relevant_categories(job.categories)
    # @emails = @contractors.map(&:email)
    mail(to: @user.email, bcc: @emails,
    subject: "Job post '#{ @job.title }' has been updated.")
  end

  private
    def set_defaults(job)
      @job = job
      @user = job.user
      @contractors = Contractor.near(job, 100).relevant_categories(job.categories)
      @emails = @contractors.map(&:email)
    end

end
