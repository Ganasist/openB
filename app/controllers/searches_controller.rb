class SearchesController < ApplicationController
	def show
		if params[:search].present?
			@jobs = Job.zip_search(params[:search])
			# @jobs = Job.near(params[:search], 50).order(:updated_at).reverse_order
			@contractors = Contractor.near(params[:search], 50).order(:updated_at).reverse_order
		else
			@jobs = Job.all.limit(20)
			@contractors = Contractor.all.limit(20)
		end
	end
end