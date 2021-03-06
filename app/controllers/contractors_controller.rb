class ContractorsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: ContractorDatatable.new(view_context) }
    end
  end

  def show
    @contractor = Contractor.includes(:upload).find(params[:id])

    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end

    @examples = @contractor.examples.order(updated_at: :desc).page(params[:examples])

    @gallery_images_count = @contractor.uploads.where(after: true).count

    @job_feed = Job.near(@contractor, @contractor.search_radius)
                   .relevant_categories(@contractor.categories)
                   .searching
                   .order(updated_at: :desc)

    @current_jobs = Job.where(contractor: @contractor).includes(:user, :uploads, :contractor, :review).order(updated_at: :desc)

    @jobs = Kaminari.paginate_array(@current_jobs + @job_feed).page(params[:jobs])

    @bids = @contractor.bids.includes(:job).order(updated_at: :desc).page(params[:bids]).per(28)

    @reviews = @contractor.reviews
                          .includes(:reviewable, :reviewerable)
                          .order(updated_at: :desc)
                          .page(params[:reviews]).per(5)
  end
end
