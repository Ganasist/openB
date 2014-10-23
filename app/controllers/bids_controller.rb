class BidsController < ApplicationController
	before_filter :authenticate_contractor!
	def new
		@job = Job.find(params[:job_id])
		@bid = @job.bids.new
	end

	def create
    @bid = Bid.new(bid_params)
    @bid.contractor = current_contractor
    @bid.job = Job.find(params[:job_id])
    if @bid.save
      redirect_to current_contractor, notice: 'Bid was successfully created!'
    else
      redirect_to :back, alert: "#{@bid.errors.full_messages.to_sentence}"
    end
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:cost, :duration, :duration_unit)
    end
end
