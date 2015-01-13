class SessionsController < Devise::SessionsController
  # before_filter :configure_permitted_parameters, only: :create

  protected

    # def configure_permitted_parameters
    #   devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    # end

    def after_sign_in_path_for(resource)
      current_member
    end
end
