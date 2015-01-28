class BidsController < ApplicationController
	before_filter :set_bid, only: [:update, :accept_bid, :reject_bid, :destroy]
	before_filter :authorize_contractor, except: [:create, :accept_bid, :reject_bid]
	before_filter :authorize_create_bid, only: :create
	before_filter :authorize_user, only: [:accept_bid, :reject_bid]

	def create
    @bid = Bid.new(bid_params)
    @bid.contractor = current_contractor
    @bid.job = Job.find(params[:job_id])
    if @bid.save
			BidMailer.create(@bid).deliver_later
      redirect_to :back, notice: "Your bid for '#{ @bid.job.title }' has been created. #{ @bid.job.user.fullname } is being notified now."
    else
      redirect_to :back, alert: "#{ @bid.errors.full_messages.to_sentence }"
    end
  end

  def edit
    @bid = current_contractor.bids.where(job_id: params[:job_id])
  end

  def update
		@bid.rejected = false
    if @bid.update(bid_params)
			BidMailer.update(@bid).deliver_later
      redirect_to :back, notice: "Your bid for '#{ @bid.job.title }' has been updated. #{ @bid.job.user.fullname } is being notified now."
    else
      redirect_to :back, alert: "#{ @bid.errors.full_messages.to_sentence }"
    end
  end

  def accept_bid
		@bid.job.activate!(@bid)
    # @bid.accept
		BidMailer.accept(@bid).deliver_later
		# Email job owner & bid contractor. Email losing bids?
    redirect_to :back, notice: "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been accepted. #{ @bid.contractor.company_name } is being notified now."
  end

  def reject_bid
    @bid.reject
		# bid contractor
		BidMailer.reject(@bid).deliver_later
    redirect_to :back, error: "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been rejected. #{ @bid.contractor.company_name } is being notified now."
  end

  def destroy
    @job = @bid.job
    @bid.destroy
    redirect_to current_contractor, notice: "Your bid for '#{ @job.title }' has been removed."
  end

  private
		def set_bid
			@bid = Bid.find(params[:id])
		end

		def authorize_contractor
			unless current_contractor == @bid.contractor
				redirect_to current_member || root_path, alert: 'Access denied'
			end
		end

		def authorize_create_bid
			unless contractor_signed_in?
				redirect_to current_member || root_path, alert: 'Access denied'
			end
		end

		def authorize_user
			unless current_user == @bid.job.user
				redirect_to current_member || root_path, alert: 'Access denied'
			end
		end

    def bid_params
      params.require(:bid).permit(:cost, :pdf)
    end
end
