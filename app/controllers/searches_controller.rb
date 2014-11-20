class SearchesController < ApplicationController
	def show
		if params[:search].present?
			@jobs = Job.zip_search(params[:search])
			@contractors = Contractor.zip_search(params[:search])
		else
			@jobs = Job.where(contractor_id: nil).limit(20)
			@contractors = Contractor.all.limit(20)
		end
	end
end