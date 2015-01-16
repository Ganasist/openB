module API
  class V1::UsersController < ApplicationController
    def index
      @users = User.all.order(updated_at: :desc).page(params[:users]).per(10)

      if category = params[:search]
        @users = @users.relevant_categories(category)
                       .order(updated_at: :desc)
                       .page(params[:users])
                       .per(10)
      end

      render :index
    end

    def show

      @user = User.includes(:upload, :reviews).find(params[:id])

      if (current_user == @user) && !@user.complete_profile?
        @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
      end

      @jobs = @user.jobs.includes(:contractor).order(created_at: :desc).page(params[:jobs])

      @reviews = @user.reviews.order(updated_at: :desc).page(params[:reviews]).per(5)

      render :show
    end
  end
end
