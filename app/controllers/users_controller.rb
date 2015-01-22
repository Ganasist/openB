class UsersController < ApplicationController
  before_filter :user_privacy

  def show
    @user = User.includes(:upload, :reviews).find(params[:id])
    if (current_user == @user) && !current_user.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end
    @jobs = @user.jobs.includes(:contractor, :uploads, :review).order(created_at: :desc).page(params[:jobs])

    @contractor_feed = Contractor.includes(:upload)
                                 .near(@user, @user.search_radius)
                                 .relevant_categories(@user.categories)
                                 .order(updated_at: :desc)

    @bids = @user.bids.includes(:job).order(updated_at: :desc).page(params[:bids]).per(28)
    @reviews = @user.reviews.order(created_at: :desc).page(params[:reviews]).per(5)
  end

  private
    def user_privacy
      unless member_signed_in?
        redirect_to new_user_registration_path, alert: 'You need to sign up or sign in to see that page.'
      end
    end
end
