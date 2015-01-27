class Users::RegistrationsController < RegistrationsController
  before_filter :configure_account_update_params, only: :update

  def create
    super
    if @user.persisted?
      WelcomeMailer.user_welcome(@user).deliver_later
    end
  end

  def update
    @user = User.find(current_user.id)

    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@user, params)
      @user.reset_authentication_token
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      # sign_in @user, bypass: true
      redirect_to root_path, notice: 'Your credentials and iOS token have been reset.'
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      sign_in :user, @user, :bypass => true
      respond_with @user, location: after_update_path_for(@user)
    end

    if successfully_updated
      return
    else
      render 'edit'
    end
  end

  protected
    # check if we need password to update user data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(user, params)
      user.email != params[:user][:email] ||
        params[:user][:password].present? ||
        params[:user][:password_confirmation].present?
    end

    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) { |a| a.permit(:name, :email, :address,
                                                                     :longitude, :latitude,
                                                                     { categories: [] },
                                                                     :password,
                                                                     :current_password,
                                                                     :password_confirmation,
                                                                     :search_radius,
                                                                     :phone,
                                                                     upload_attributes: [:id,
                                                                                         :image,
                                                                                         :_destroy,
                                                                                         :image_remote_url]) }
    end
end
