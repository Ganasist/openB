class SearchesController < ApplicationController
	def show
		@search = Search.new
		@search.zip_code = params[:search]
		if @search.valid? && Search.exists?(zip_code: params[:search])
			@jobs = Job.zip_search(params[:search])
			@contractors = Contractor.zip_search(params[:search])
		else
			flash[:error] = "Zip code #{ @search.zip_code } wasn't found. Please enter a valid 5-digit US zip code"
      redirect_to :back
		end
	end
end