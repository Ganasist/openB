class BidMailer < ApplicationMailer

  def create(bid)
    set_defaults(bid)
    puts 'set defaults'
    mail(to: @user.email,
    subject: "#{ @contractor.company_name } bid $#{ @bid.cost } on '#{ @bid.job.title }'")
  end

  def update(bid)
    set_defaults(bid)
    mail(to: @user.email,
    subject: "#{ @contractor.company_name } updated their bid to $#{ @bid.cost } for '#{ @bid.job.title }'")
  end

  def accept(bid)
    set_defaults(bid)
    mail(to: [@user.email, @contractor.email],
    subject: "#{ @user.fullname } accepted your bid of $#{ @bid.cost } for '#{ @bid.job.title }'")
  end

  def reject(bid)
    set_defaults(bid)
    mail(to: [@user.email, @contractor.email],
    subject: "Your bid of $#{ @bid.cost } for '#{ @job.title }' was rejected.")
  end

  private
    def set_defaults(bid)
      @bid = bid
      @contractor = bid.contractor
      @job = bid.job
      @user = bid.job.user
    end
end
