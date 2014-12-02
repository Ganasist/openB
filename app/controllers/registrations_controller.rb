class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_account_create_params, only: :create

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
		def after_sign_up_path_for(resource)
			if resource.sign_in_count == 1
				flash[:notice] = 'Welcome to OpenBid! Please complete your profile.'
				edit_registration_path(resource) 
			else
				after_sign_in_path(resource)
			end
    end

    def after_update_path_for(resource)
      current_user || current_contractor
    end

    def configure_account_create_params
      devise_parameter_sanitizer.for(:sign_up) { |a| a.permit(:zip_code,
                                                              :email,
                                                              :password, 
                                                              :password_confirmation) }
    end
end