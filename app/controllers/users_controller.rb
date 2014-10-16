class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_filter :user_privacy, except: :index
  before_filter :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    id = params[:id] || current_user.id
    @user = User.find(id)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_privacy
      unless current_user && (current_user == @user)
        redirect_to current_user, alert: 'Access denied.'
      end
    end

    def admin_only
      unless current_user.admin?
        redirect_to :back, :alert => "Access denied."
      end
    end

    def secure_params
      params.require(:user).permit(:role)
    end
end
