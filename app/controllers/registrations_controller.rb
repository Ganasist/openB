class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_account_update_params, only: [:update]

	protected
		def after_sign_up_path_for(resource)
      current_user || current_contractor
    end

    def after_update_path_for(resource)
      current_user || current_contractor
    end

    def configure_account_update_params
      devise_parameter_sanitizer.for(:account_update) { |a| a.permit(:name, :email, :current_password, :password, 
                                                                     :password_confirmation, :image, 
                                                                     :delete_image, :image_remote_url) }
    end
end