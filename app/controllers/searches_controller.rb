class SearchesController < ApplicationController
	def show
		@search = Search.new
		@search.zip_code = params[:zip_code]
		@search.distance = params[:distance].present? ? params[:distance] : 50

		unless Rails.env.staging?
			if @search.valid? && Search.exists?(['zip_code = ?', params[:zip_code]])
				@jobs = Job.zip_search(params[:zip_code], @search.distance).includes(:uploads)
				@contractors = Contractor.zip_search(params[:zip_code], @search.distance).includes(:uploads)
			elsif !Search.exists?(['zip_code = ?', params[:zip_code]])
				redirect_to :back,
					alert: "Zip code #{ @search.zip_code } wasn't found. Please enter a valid 5-digit US zip code."
			else
	      redirect_to :back,
					alert: "#{ @search.errors.full_messages.to_sentence }"
			end
		else
			if @search.valid?
				@jobs = Job.zip_search(params[:zip_code], @search.distance).includes(:uploads)
				@contractors = Contractor.zip_search(params[:zip_code], @search.distance).includes(:uploads)
			else
				redirect_to :back,
					alert: "Zip code #{ @search.zip_code } wasn't found. Please enter a valid 5-digit US zip code."
			end
		end
	end
end
