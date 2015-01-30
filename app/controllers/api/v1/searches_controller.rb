class API::V1::SearchesController < API::V1::VersionController
  def show
    @search = Search.new
    @search.latitude   = params[:latitude]
    @search.longitude  = params[:longitude]
    @search.categories = params[:categories]
    @search.distance   = params[:distance].present? ? params[:distance] : 50

    if @search.valid? && (@search.latitude.present? && @search.longitude.present?)
      @jobs = Job.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)
      @contractors = Contractor.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)

      if categories = params[:categories]
        @jobs = @jobs.relevant_categories(@search.categories)
        @contractors = @contractors.relevant_categories(@search.categories)
      end
      render :show
    else
      render json: { message: "Invalid search: #{ @search.errors.full_messages.to_sentence }" }, status: 422
    end
  end
end
