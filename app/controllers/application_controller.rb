class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

	  # def configure_permitted_parameters
	  #   devise_parameter_sanitizer.for(:sign_up) do |u|
	  #     u.permit(:email, :password, :password_confirmation)
	  #   end
	  #   devise_parameter_sanitizer.for(:account_update) { |a| a.permit(:name, :email, :password, 
	  #   																															 :password_confirmation, :image, 
	  #   																															 :delete_image, :image_remote_url)}
	  # end

	  def after_sign_in_path_for(resource)
		  current_user || current_contractor
		end
end