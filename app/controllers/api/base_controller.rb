class API::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'Page not found', status: 404
  end
end
