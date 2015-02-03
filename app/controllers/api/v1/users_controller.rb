class API::V1::UsersController < API::V1::VersionController

  def show
    @user = User.includes(:upload).find(params[:id])

    @jobs = @user.jobs.includes(:uploads, :bids).order(created_at: :desc).page(params[:jobs])

    @contractor_feed = Contractor.includes(:upload)
                                 .near(@user, @user.search_radius)
                                 .relevant_categories(@user.categories)
                                 .order(updated_at: :desc)

    @reviews = @user.reviews.order(updated_at: :desc).page(params[:reviews]).per(5)

    @bids = @user.bids.order(updated_at: :desc).page(params[:bids]).per(28)

    render :show
  end
end
