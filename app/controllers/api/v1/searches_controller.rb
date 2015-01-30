class API::V1::SearchesController < API::V1::VersionController
  def show
    @search = Search.new
    @search.latitude  = params[:latitude]
    @search.longitude = params[:longitude]
    @search.distance  = params[:distance].present? ? params[:distance] : 50

    if @search.valid? && (@search.latitude.present? && @search.longitude.present?)
      @jobs = Job.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)
      @contractors = Contractor.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)
      render :show
    else
      render json: { message: 'Invalid or incomplete search parameters' }, status: 422
    end
  end
end
