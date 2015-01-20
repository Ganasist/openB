class API::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  def new
    puts 'new session'
    render json: { user: 'tests' }
  end

  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).
  def create
    puts 'there'
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    puts 'here'
    current_user.update authentication_token: nil

    respond_to do |format|
      format.json {
        render json: {
          user: current_user,
          status: :ok,
          authentication_token: current_user.authentication_token
        }
      }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    respond_to do |format|
      format.json {
        if current_user
          current_user.update authentication_token: nil
          signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
          render :json => {}.to_json, :status => :ok
        else
          render :json => {}.to_json, :status => :unprocessable_entity
        end
      }
    end
  end

  before_action :authenticate

  private
    def authenticate
      puts 'authenticating'
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.find_by(authentication_token: token)
        puts @current_user
        self.headers['WWW-Authenticate'] = 'Token realm="Session"'
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Base"'
      render json: 'Bad Credentials', status: 401
    end
end
