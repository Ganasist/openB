class API::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'Page not found', status: 404
  end

  def current_user
    @current_user ||= User.where(authentication_token: params[:auth_token]).first
  end
end
