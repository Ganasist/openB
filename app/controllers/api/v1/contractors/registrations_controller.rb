class API::V1::Contractors::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :authenticate, except: [:new, :create]
  skip_before_filter :authenticate_scope!
  before_filter :contractor_params, only: [:create, :update]

  def new
    @contractor = Contractor.new
    render :new
  end

  def create
    @contractor = Contractor.new(contractor_params)

    if @contractor.save
      render json: @contractor.as_json(auth_token: @contractor.authentication_token,
                                            email: @contractor.email),
           status: 201
      WelcomeMailer.contractor_welcome(@contractor).deliver_later
      return
    else
      warden.custom_failure!
      render json: @contractor.errors,
           status: 422
    end
  end

  def edit
    render :edit
  end

  def update
    successfully_updated = if needs_password?(@contractor, params)
      @contractor.reset_authentication_token
      @contractor.update_with_password(contractor_params)
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:contractor].delete(:current_password)
      @contractor.update_without_password(contractor_params)
    end

    if successfully_updated
      render json: @contractor.to_json, status: 202
    else
      warden.custom_failure!
      render json: @contractor.errors,
      status: 422
    end
  end

  protected

    # check if we need password to update contractor data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(contractor, params)
      contractor.email != request.headers['Email'] ||
      params[:contractor][:password].present? ||
      params[:contractor][:password_confirmation].present?
    end

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      contractor_email  = request.headers['Email'].presence
      @contractor       = contractor_email && Contractor.find_by(email: request.headers['Email'])

      authenticate_with_http_token do |token, options|
        if @contractor && Devise.secure_compare(@contractor.authentication_token, token)
          return @contractor
        end
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Contractor Registration"'
      render json: 'Bad Credentials', status: 401
    end

    def contractor_params
      params.require(:contractor).permit(:name, :email, :phone,
                                        :address, { categories: [] },
                                        :longitude, :latitude,
                                        :search_radius, :company_name,
                                        :password, :current_password,
                                        :password_confirmation,
                                        :description, upload_attributes: [:id,
                                                                          :image,
                                                                          :_destroy,
                                                                          :image_remote_url])
    end
  end
