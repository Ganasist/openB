class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_member
  helper_method :member_signed_in?

  # rescue_from ActiveRecord::RecordNotFound do |exception|
  #   redirect_to current_member, alert: 'Page not found'
  # end

	protected
    def current_member
      current_user || current_contractor
    end

    def member_signed_in?
      user_signed_in? || contractor_signed_in?
    end

    def after_sign_out_path_for(resource)
      root_path
    end

		def configure_permitted_parameters
		  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,
		  																												:password,
		  																												:remember_me) }
		end
end
