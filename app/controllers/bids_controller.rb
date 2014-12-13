class BidsController < ApplicationController
  respond_to :html
	before_filter :authenticate_contractor!, except: [:accept_bid, :reject_bid]

	def create
    @bid = Bid.new(bid_params)
    @bid.contractor = current_contractor
    @bid.job = Job.find(params[:job_id])
    if @bid.save
      redirect_to :back, notice: "Your bid for '#{ @bid.job.title }' has been created"
    else
      redirect_to :back, alert: "#{ @bid.errors.full_messages.to_sentence }"
    end
  end

  def edit
    @bid = current_contractor.bids.where(job_id: params[:job_id])
  end

  def update
    @bid = Bid.find(params[:id])
    if @bid.update(bid_params)
      flash[:notice] = 'Bid was successfully updated.'
      redirect_to :back, notice: "Your bid for '#{ @bid.job.title }' has been updated"
    else
      redirect_to :back, alert: "#{ @bid.errors.full_messages.to_sentence }"
    end
  end

  def accept_bid
    @bid = Bid.find(params[:id])
    # make sure only job owner can accept / reject bids
    @bid.accept
    @bid.job.activate!(@bid)
    flash[:notice] = "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been accepted. They are being notified now."
    redirect_to :back
  end

  def reject_bid
    @bid = Bid.find(params[:id])
    @bid.reject
    flash[:error] = "Bid from #{ @bid.contractor.company_name } for $#{ @bid.cost } has been rejected. They are being notified now."
    redirect_to :back
  end

  def destroy
    @bid = Bid.find(params[:id])
    @job = @bid.job
    @bid.destroy
    redirect_to current_contractor, notice: "Your bid for '#{ @job.title }' has been removed"
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:cost)
    end
end
