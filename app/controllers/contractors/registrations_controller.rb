class Contractors::RegistrationsController < RegistrationsController
  before_filter :configure_account_update_params, only: :update

  def create
    super
    if @contractor.persisted?
      WelcomeMailer.contractor_welcome(@contractor).deliver_later
    end
  end

  def update
    @contractor = Contractor.find(current_contractor.id)

    if params[:contractor][:password].blank? && params[:contractor][:password_confirmation].blank?
      params[:contractor].delete(:password)
      params[:contractor].delete(:password_confirmation)
    end

    successfully_updated = if needs_password?(@contractor, params)
      @contractor.reset_authentication_token
      if @contractor.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
        flash[:notice] = 'Your credentials and iOS token have been reset. Please sign-in again if needed.'
        sign_in_and_redirect(@contractor)
      end
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:contractor].delete(:current_password)
      if @contractor.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
        redirect_to @contractor
      end
    end

    if successfully_updated
      return
    else
      render 'edit'
    end
  end

  protected
  def after_sign_up_path_for(resource)
    if resource.sign_in_count == 1
      flash[:notice] = 'Welcome to OpenBid! Please complete your profile.'
      edit_contractor_registration_path
    else
      after_sign_in_path
    end
  end

    # check if we need password to update user data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(contractor, params)
      contractor.email != params[:contractor][:email] ||
        params[:contractor][:password].present? ||
        params[:contractor][:password_confirmation].present?
    end

    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) { |a| a.permit(:name, :email,
                                                                     :phone,
                                                                     :address,
                                                                     { categories: [] },
                                                                     :longitude,
                                                                     :latitude,
                                                                     :search_radius,
                                                                     :company_name,
                                                                     :password,
                                                                     :current_password,
                                                                     :password_confirmation,
                                                                     :description, upload_attributes: [:id,
                                                                                                       :image,
                                                                                                       :_destroy,
                                                                                                       :image_remote_url]) }
    end
end
