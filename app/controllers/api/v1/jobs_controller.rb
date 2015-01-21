class API::V1::JobsController < API::BaseController
  before_action :set_job, only: [:show, :edit, :update, :destroy,
                                 :resume_search, :mark_as_complete, :cancel_job]

  before_action :authenticate, only: [:show, :new, :create]

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
    @job = @member.jobs.new(job_params)
    if @job.save
      JobMailer.create(@job).deliver_later
      render :show, status: 200
    else
      render json: @job.errors, status: 422
    end
  end

  def edit

  end

  def update
    if @job.update(job_params)
      JobMailer.update(@job).deliver_later
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to current_user, notice: "'#{ @job.title }' was successfully deleted" }
      format.js
    end
  end

  # make sure current_user owns this job....
  def resume_search
    @job.resume_search!
    redirect_to @job, notice: "Contractor search for '#{ @job.title }' has been resumed. Please check the job's bids."
  end

  # make sure current_user owns this job....
  def mark_as_complete
    @job.mark_as_complete!
    if @job.contractor_id.nil?
      redirect_to current_user, notice: "Your job '#{ @job.title }' has been marked as complete."
    elsif @job.review.nil?
      redirect_to new_job_review_path(@job)
    else
      redirect_to edit_job_review_path(@job)
    end
  end

  # make sure current_user owns this job....
  def cancel_job
    @job.cancel!
    if @job.contractor_id.nil?
      redirect_to current_user, notice: "Your job '#{ @job.title }' has been cancelled."
    elsif @job.review.nil?
      redirect_to new_job_review_path(@job)
    else
      redirect_to edit_job_review_path(@job)
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

    def job_params
      params.require(:job).permit(:state, :address, :longitude, :latitude, :phone,
                                  :title, :bidding_period, :description, { categories: [] })
    end
  end
