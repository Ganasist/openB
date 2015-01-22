class API::V1::ExamplesController < API::BaseController
  before_action :authenticate, except: :show
  before_action :set_example, only: [:show, :edit, :update, :destroy]
  before_action :ensure_permission, only: [:edit, :update, :destroy]

    def show

    end

    def new
      @example = Example.new
      render :new
    end

    def create
      @example = @member.examples.build(example_params)
      if @example.save
        render :show, status: 201
      else
        render json: @example.errors, status: 422
      end
    end

    def edit
      render :edit
    end

    def update
      if @example.update(example_params)
        render :show, status: 202
      else
        render json: @job.errors, status: 422
      end
    end

    def destroy
      @job.destroy
      render json: {}, status: 204
    end

    private
    def authenticate
      puts 'authenticating'
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      member_email  = request.headers['Email'].presence
      @member       = member_email && (User.find_by(email: request.headers['Email']) || Contractor.find_by(email: request.headers['Email']))

      authenticate_with_http_token do |token, options|
        if @member && Devise.secure_compare(@member.authentication_token, token)
          return @member
        end
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Examples"'
      render json: 'Bad Credentials', status: 401
    end

    def set_example
      @example = Example.find(params[:id])
    end

    def ensure_permission
      puts 'Ensuring permission'
      if @member == @example.contractor
        return
      else
        render json: "You don't have access.", status: 403
      end
    end

    def example_params
      params.require(:job).permit(:address, :longitude, :latitude, :title, :description,
                                  :duration, :duration_unit, :cost, { categories: [] })
    end
  end
