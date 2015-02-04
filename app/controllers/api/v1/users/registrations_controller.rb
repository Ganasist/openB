class API::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :authenticate, except: [:new, :create]
  skip_before_filter :authenticate_scope!
  before_filter :user_params, only: [:create, :update]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(id: @user.id,
                         auth_token: @user.authentication_token,
                              email: @user.email),
           status: 201
      WelcomeMailer.user_welcome(@user).deliver_later
      return
    else
      warden.custom_failure!
      render json: @user.errors,
           status: 422
    end
  end

  def edit
    render :edit
  end

  def update
    successfully_updated = if needs_password?(@user, params)
      @user.reset_authentication_token
      @user.update_with_password(user_params)
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(user_params)
    end

    if successfully_updated
      render json: @user.to_json, status: 202
    else
      warden.custom_failure!
      render json: @user.errors,
           status: 422
    end
  end

  protected

    # check if we need password to update user data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(user, params)
      user.email != request.headers['Email'] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
    end

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      user_email  = request.headers['Email'].presence
      @user       = user_email &&
                    User.find_by(email: request.headers['Email'])

      authenticate_with_http_token do |token, options|
        if @user && Devise.secure_compare(@user.authentication_token, token)
          return @user
        end
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="User Registration"'
      render json: 'Bad Credentials', status: 401
    end

    def user_params
      params.require(:user).permit(:name, :email, :address,
                                   :longitude, :latitude,
                                   { categories: [] },
                                   :search_radius,
                                   :password, :current_password,
                                   :password_confirmation, :phone,
                                   upload_attributes: [:id, :image,
                                                       :_destroy,
                                                       :image_remote_url])
    end
end
