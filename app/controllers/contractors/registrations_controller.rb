class Contractors::RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    @contractor = Contractor.find(current_contractor.id)

    successfully_updated = if needs_password?(@contractor, params)
      @contractor.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:contractor].delete(:current_password)
      @contractor.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @contractor, bypass: true
      redirect_to after_update_path_for(@contractor)
    else
      render "edit"
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

    # check if we need password to update user data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(contractor, params)
      contractor.email != params[:contractor][:email] ||
        params[:contractor][:password].present? ||
        params[:contractor][:password_confirmation].present?
    end

    # def configure_sign_up_params
    #   devise_parameter_sanitizer.for(:sign_up) { |a| a.permit(:email, :password, 
    #                                                           :password_confirmation)}
    # end

    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) { |a| a.permit(:name, :email, :password, 
                                                                     :password_confirmation, :image, 
                                                                     :delete_image, :image_remote_url) }
    end

    def after_sign_up_path_for(resource)
      super(resource)
    end

    def after_inactive_sign_up_path_for(resource)
      super(resource)
    end

    def after_update_path_for(resource)
      current_contractor
    end
end
