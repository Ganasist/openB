class BidMailer < ApplicationMailer
  default from: 'no-reply@openbid.com'

  def create(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: @user.email, subject: "#{ @contractor.company_name } bid $#{ @bid.cost } on your job '#{ @bid.job.title }'")
  end

  def update(bid)
    @bid = bid
    @contractor = bid.contractor
    @job = bid.job
    @user = bid.job.user
    mail(to: @user.email, subject: "#{ @contractor.company_name } updated their bid to $#{ @bid.cost } for '#{ @bid.job.title }'")
  end

  def accept(bid)

  end

  def reject(bid)

  end
end
