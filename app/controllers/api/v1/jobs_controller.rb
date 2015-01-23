class API::V1::JobsController < API::BaseController
  before_action :authenticate

  before_action :set_job, only: [:show, :edit, :update, :destroy,
                                 :resume_search, :mark_as_complete, :cancel_job]

  before_action :ensure_permission, only: [:edit, :update, :destroy, :resume_search,
                                           :mark_as_complete, :cancel_job]


  def index
    @jobs = Job.all.includes(:uploads, :bids).order(updated_at: :desc)
               .page(params[:jobs])
               .per(10)
    if category = params[:search]
      @jobs = Job.relevant_categories(category).includes(:uploads, :bids)
                 .order(updated_at: :desc)
                 .page(params[:jobs])
                 .per(10)
    end
  end

  def show
    puts @member.fullname
    @bids = @job.bids.where(rejected: false)
                .order(updated_at: :desc)
                .page(params[:bids])
                .per(5)
  end

  def new
    @job = @member.jobs.build
    render :new
  end

  def create
    raise params.inspect
    @job = @member.jobs.new(job_params)
    if @job.save
      JobMailer.create(@job).deliver_later
      render :show, status: 201
    else
      render json: @job.errors, status: 422
    end
  end

  def edit
    render :edit
  end

  def update
    if @job.update(job_params)
      JobMailer.update(@job).deliver_later
      render :show, status: 202
    else
      render json: @job.errors, status: 422
    end
  end

  def destroy
    @job.destroy
    render json: {}, status: 204
  end

  def resume_search
    @job.resume_search!
    render :show, status: 202
  end

  def mark_as_complete
    @job.mark_as_complete!
    if @job.contractor_id.nil?
      render json: :show, status: 204
    elsif @job.review.nil?
      redirect_to new_api_v1_job_review(@job, format: :json), status: 204
    else
      redirect_to edit_api_v1_job_review(@job, format: :json), status: 204
    end
  end

  def cancel_job
    @job.cancel!
    if @job.contractor_id.nil?
      render json: :show, status: 204
    elsif @job.review.nil?
      redirect_to new_api_v1_job_review(@job, format: :json), status: 204
    else
      redirect_to edit_api_v1_job_review(@job, format: :json), status: 204
    end
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
      self.headers['WWW-Authenticate'] = 'Token realm="Jobs"'
      render json: 'Bad Credentials', status: 401
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def ensure_permission
      if @member == @job.user
        return
      else
        render json: "You don't have access.", status: 403
      end
    end

    def job_params
      params.require(:job).permit(:state, :address, :longitude, :latitude, :phone,
                                  :title, :bidding_period, :description, { categories: [] })
    end
  end
