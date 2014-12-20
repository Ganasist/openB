class BidMailer < ActionMailer::Base
  default from: 'noreply@openbid.com'
  before_action :set_logo

  def create(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: @user.email,
    subject: "#{ @contractor.company_name } bid $#{ @bid.cost } on '#{ @bid.job.title }'")
  end

  def update(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: @user.email,
    subject: "#{ @contractor.company_name } updated their bid to $#{ @bid.cost } for '#{ @bid.job.title }'")
  end

  def accept(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: [@user.email, @contractor.email],
    subject: "#{ @user.fullname } accepted your bid of $#{ @bid.cost } for '#{ @bid.job.title }'")
  end

  def reject(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: [@user.email, @contractor.email],
    subject: "Your bid of $#{ @bid.cost } for '#{ @job.title }' was rejected.")
  end

  private
    def set_logo
      attachments.inline['logo.png'] = File.read("#{ Rails.root.to_s + '/app/assets/images/logo.png' }")
    end
end
