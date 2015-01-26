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

    successfully_updated = if needs_password?(@contractor, params)
      @contractor.reset_authentication_token
      @contractor.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:contractor].delete(:current_password)
      @contractor.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @contractor, bypass: true
      redirect_to root_path, notice: 'Your credentials and iOS token have been reset.'
    else
      render 'edit'
    end
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
