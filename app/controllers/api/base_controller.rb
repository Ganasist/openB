class API::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  acts_as_token_authentication_handler_for User
  # acts_as_token_authentication_handler_for Contractor

  private

end
