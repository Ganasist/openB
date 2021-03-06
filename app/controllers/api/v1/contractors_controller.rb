class API::V1::ContractorsController < API::V1::VersionController

  def index
    @contractors = Contractor.all.order(updated_at: :desc).page(params[:contractors]).per(10)

    if category = params[:search]
      @contractors = @contractors.relevant_categories(category)
                                 .order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(10)
    end

    render :index
  end

  def categories
    render json: Contractor.categories, status: 200
  end

  def show
    @contractor = Contractor.find(params[:id])

    @examples = @contractor.examples.includes(:uploads).order(updated_at: :desc).page(params[:examples])

    @gallery_images = @contractor.uploads.where(after: true)

    @job_feed = Job.includes(:uploads).near(@contractor, @contractor.search_radius)
                                      .relevant_categories(@contractor.categories)
                                      .searching.order(updated_at: :desc)

    @current_jobs = Job.includes(:uploads).where(contractor: @contractor).order(updated_at: :desc)

    @jobs = Kaminari.paginate_array(@current_jobs + @job_feed).page(params[:jobs])

    @bids = @contractor.bids.order(updated_at: :desc).page(params[:bids]).per(28)

    @reviews = @contractor.reviews.order(updated_at: :desc).page(params[:reviews]).per(5)

    render :show
  end
end
