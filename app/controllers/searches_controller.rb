class SearchesController < ApplicationController
	def show
		if params[:search]
			@jobs = Job.near(params[:search], 50).order(:updated_at).reverse_order
			@contractors = Contractor.near(params[:search], 50).order(:updated_at).reverse_order
		end
	end
end