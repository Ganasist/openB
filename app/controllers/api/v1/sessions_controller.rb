class API::V1::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create, :token_reset ]
  skip_before_filter :verify_authenticity_token

  before_filter :ensure_params_exist

  def create
    resource = resource_class.new
    member = request.fullpath.split('/')[2].classify.constantize
    resource = member.find_for_database_authentication( email: params[:member][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:member][:password])
      render json: { success: true, id: resource.id, class: resource.class.name, auth_token: resource.authentication_token, email: resource.email }
      return
    end
    invalid_login_attempt
  end

  def token_reset
    resource = resource_class.new
    member = request.fullpath.split('/')[2].classify.constantize
    resource = member.find_for_database_authentication( email: params[:member][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:member][:password])
      resource.reset_authentication_token
      render json: { success: true, id: resource.id, class: resource.class.name, auth_token: resource.authentication_token, email: resource.email }
      return
    end
    invalid_login_attempt
  end

  protected
    def get_resource
      resource = resource_class.new
      member = request.fullpath.split('/')[2].classify.constantize
      resource = member.find_for_database_authentication( email: params[:member][:email])
      return invalid_login_attempt unless resource
    end

    def ensure_params_exist
      puts params[:member]
      return unless params[:member][:email].blank?
      render json: { success: false, message: 'missing Email parameter' }, status: 422
    end

    def invalid_login_attempt
      warden.custom_failure!
      render json: { success: false, message: 'Error with your login or password' }, status: 401
    end
end
