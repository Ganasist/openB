class BidsController < ApplicationController

	def new
		@job = Job.find(params[:job_id])
		@bid = @job.bids.build(job: @job, contractor: current_contractor)
	end
end
