class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_sign_up_params, only: [:create]


	protected
		# You can put the params you want to permit in the empty array.
		def configure_sign_in_params
		  devise_parameter_sanitizer.for(:sign_up) { |a| a.permit(:email, :password, 
                                                              :password_confirmation)}
		end
end