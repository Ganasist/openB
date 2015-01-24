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

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
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
                                                                     :phone,
                                                                     upload_attributes: [:id,
                                                                                         :image,
                                                                                         :_destroy,
                                                                                         :image_remote_url]) }
    end
end
