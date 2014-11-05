class SearchesController < ApplicationController
	def show
		if params[:search].present?
			@jobs = Job.zip_search(params[:search])
			# @jobs = Job.near(params[:search], 50).order(:updated_at).reverse_order
			@contractors = Contractor.near(params[:search], 50).order(:updated_at).reverse_order
		else
			@jobs = Job.where(contractor_id: nil).limit(20)
			@contractors = Contractor.all.limit(20)
		end
	end
end