class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:edit, :update, :destroy]
  before_action :authenticate_contractor!, except: [:index, :show]
  before_action :block_visitors

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
    @contractor = Contractor.includes(:examples, :bids)
                            .find(params[:id])

    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end

    @examples = @contractor.examples
                           .includes(:uploads)
                           .order(updated_at: :desc)
                           .page(params[:examples])

    # @comments = @contractor.comments.page(params[:comments])

    @job_feed = Job.near(@contractor, @contractor.search_radius)
               .relevant_categories(@contractor.categories)
               .searching
               .includes([:user, :uploads])
               .order(updated_at: :desc)

    @current_jobs = Job.where(contractor: @contractor)
                       .order(updated_at: :desc)

    @jobs = Kaminari.paginate_array(@current_jobs + @job_feed)
                    .page(params[:jobs])

    @bids = @contractor.bids
                       .includes(:job)
                       .order(updated_at: :desc)
                       .page(params[:bids]).per(28)

    @reviews = @contractor.reviews
                          .order(updated_at: :desc)
                          .page(params[:reviews]).per(5)
  end

  def destroy
    contractor = Contractor.find(params[:id])
    contractor.destroy
    redirect_to contractors_path, notice: 'contractor deleted.'
  end

  private

    def block_visitors
      unless user_signed_in? || contractor_signed_in?
        redirect_to root_path, alert: 'Sign up or sign in to access Contractor profiles'
      end
    end

    def set_contractor
      @contractor = Contractor.find(params[:id])
    end
end
