class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_account_create_params, only: :create

  def edit
    current_member.upload || current_member.build_upload
  end

  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:alert] = 'There was an error with the recaptcha code below. Please re-enter the code.'
      flash.delete :recaptcha_error
      render :new
    end
  end

  # def edit
  #   # resource.uploads.build
  # end

	protected

    def after_update_path_for(resource)
      current_member
    end

    def configure_account_create_params
      devise_parameter_sanitizer.for(:sign_up) { |a| a.permit(:name, :company_name,
                                                              :address,
                                                              :longitude,
                                                              :latitude,
                                                              :email,
                                                              :password,
                                                              :password_confirmation) }
    end
end
