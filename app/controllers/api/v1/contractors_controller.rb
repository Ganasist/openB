class API::V1::ContractorsController < ApplicationController
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

  def show
    @contractor = Contractor.find(params[:id])

    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end

    @examples = @contractor.examples.order(updated_at: :desc).page(params[:examples])

    @gallery_images = @contractor.uploads.where(after: true)

    @job_feed = Job.near(@contractor, @contractor.search_radius)
                   .relevant_categories(@contractor.categories)
                   .searching.order(updated_at: :desc)

    @current_jobs = Job.where(contractor: @contractor).order(updated_at: :desc)

    @jobs = Kaminari.paginate_array(@current_jobs + @job_feed).page(params[:jobs])

    @bids = @contractor.bids.order(updated_at: :desc).page(params[:bids]).per(28)

    @reviews = @contractor.reviews.order(updated_at: :desc).page(params[:reviews]).per(5)

    render :show
    # render json: [contractor, examples, gallery_images, jobs, bids, reviews], result: 200
  end
end
