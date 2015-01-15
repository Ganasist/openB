class ContractorsController < ApplicationController
  def index
    @contractors = Contractor.all.order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(10)
    if category = params[:search]
      @contractors = @contractors.relevant_categories(category)
                                 .order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(10)
    end
  end

  def show
    @contractor = Contractor.find(params[:id])

    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end

    @examples = @contractor.examples.order(updated_at: :desc).page(params[:examples])

    @gallery_images_count = @contractor.uploads.where(after: true).count

    @job_feed = Job.near(@contractor, @contractor.search_radius)
                   .relevant_categories(@contractor.categories)
                   .searching
                   .order(updated_at: :desc)

    @current_jobs = Job.where(contractor: @contractor).order(updated_at: :desc)

    @jobs = Kaminari.paginate_array(@current_jobs + @job_feed).page(params[:jobs])

    @bids = @contractor.bids.includes(:job).order(updated_at: :desc).page(params[:bids]).per(28)

    @reviews = @contractor.reviews.order(updated_at: :desc).page(params[:reviews]).per(5)
  end

  private
    def set_contractor
      @contractor = Contractor.find(params[:id])
    end
end
