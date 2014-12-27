class BidsController < ApplicationController
  # respond_to :html
	before_filter :authenticate_contractor!, except: [:accept_bid, :reject_bid]

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
    @bid = Bid.find(params[:id])
		@bid.rejected = false
    if @bid.update(bid_params)
			BidMailer.update(@bid).deliver_later
      redirect_to :back, notice: "Your bid for '#{ @bid.job.title }' has been updated. #{ @bid.job.user.fullname } is being notified now."
    else
      redirect_to :back, alert: "#{ @bid.errors.full_messages.to_sentence }"
    end
  end

  def accept_bid
		# make sure only job owner can accept / reject bids
    @bid = Bid.find(params[:id])
    @bid.accept
    @bid.job.activate!(@bid)
		BidMailer.accept(@bid).deliver_later
		# Email job owner & bid contractor. Email losing bids?
    redirect_to :back, notice: "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been accepted. #{ @bid.contractor.company_name } is being notified now."
  end

  def reject_bid
		# make sure only job owner can accept / reject bids
    @bid = Bid.find(params[:id])
    @bid.reject
		# bid contractor
		BidMailer.reject(@bid).deliver_later
    redirect_to :back, error: "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been rejected. #{ @bid.contractor.company_name } is being notified now."
  end

  def destroy
    @bid = Bid.find(params[:id])
    @job = @bid.job
    @bid.destroy
    redirect_to current_contractor, notice: "Your bid for '#{ @job.title }' has been removed."
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:cost)
    end
end
