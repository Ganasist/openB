class API::V1::SearchesController < API::V1::VersionController
  def create
    @search = Search.new(zip_code: params[:zip_code],
                         latitude: params[:latitude],
                        longitude: params[:longitude],
                       categories: params[:categories])
    @search.distance   = params[:distance].present? ? params[:distance] : 50

    if @search.valid?
      if @search.latitude.present? && @search.longitude.present?
        @jobs = Job.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)
        @contractors = Contractor.lat_lon_search(@search.latitude, @search.longitude, @search.distance).includes(:uploads)

        if categories = params[:categories]
          @jobs = @jobs.relevant_categories(@search.categories)
          @contractors = @contractors.relevant_categories(@search.categories)
        end
        render :show
      elsif @search.zip_code.present? && (Search.exists?(['zip_code = ?', @search.zip_code]) && !Rails.env.staging?)
        @jobs = Job.zip_search(@search.zip_code, @search.distance).includes(:uploads)
        @contractors = Contractor.zip_search(@search.zip_code, @search.distance).includes(:uploads)

        if categories = params[:categories]
          @jobs = @jobs.relevant_categories(@search.categories)
          @contractors = @contractors.relevant_categories(@search.categories)
        end
        render :show
      elsif @search.zip_code.present? && !Search.exists?(['zip_code = ?', @search.zip_code])
        render json: { message: "Zip code not found."}, status: 402
      end
    else
      render json: { message: "Invalid search: #{ @search.errors.full_messages.to_sentence }" }, status: 422
    end
  end
end
