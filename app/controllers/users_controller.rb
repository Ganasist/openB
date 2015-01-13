class UsersController < ApplicationController
  before_filter :user_privacy

  def show
    @user = User.includes(:upload, :reviews, jobs: [:uploads, :bids]).find(params[:id])
    if (current_user == @user) && !current_user.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end
    @jobs = @user.jobs
                 .order(created_at: :desc)
                 .page(params[:jobs])

    @reviews = @user.reviews
                    .order(created_at: :desc)
                    .page(params[:reviews])
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_privacy
      unless member_signed_in?
        redirect_to new_user_registration_path, alert: 'You need to sign up or sign in to see that page.'
      end
    end
end
