class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_account_create_params, only: :create

	protected
		def after_sign_up_path_for(resource)
			if resource.sign_in_count == 1
				flash[:notice] = 'Welcome to OpenBid! Please finish your profile below.'
				edit_registration_path(resource) 
			else
				after_sign_in_path(resource)
			end
    end

    def after_update_path_for(resource)
      current_user || current_contractor
    end

    def configure_account_create_params
      devise_parameter_sanitizer.for(:sign_up) { |a| a.permit(:email,
                                                              :password, 
                                                              :password_confirmation) }
    end
end