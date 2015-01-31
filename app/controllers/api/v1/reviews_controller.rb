class API::V1::ReviewsController < API::V1::VersionController
  before_action :authenticate
  before_action :set_job
  before_action :get_reviewable, only: [:new, :create, :edit, :update]
  before_action :get_reviewerable, only: [:new, :create, :edit, :update]

  before_action :ensure_permission, except: [:show]


  def new
    @review = Review.new(reviewable: @job, reviewerable: @job.user)
  end

  def create
    @review = Review.create(review_params)
    @review.reviewable   = @reviewable
    @review.reviewerable = @reviewerable
    if @review.save
      render :show
    else
      render :new, json: { error: "#{ @review.errors.full_messages.to_sentence }" }, status: 422
    end
  end

  def show
    @review = @job.review
  end

  def edit
    @review = @job.review
  end

  def update
    @review = @job.review
    if @review.update(review_params)
      redirect_to job_review_path(@job), notice: 'Review was successfully updated.'
    else
      render 'edit', error: "#{ @review.errors.full_messages.to_sentence }"
    end
  end

  def destroy
    @review = @job.review
    @review.destroy
    respond_to do |format|
      # format.html { redirect_to current_user, notice: "'Review for #{ @job.title }' was successfully deleted" }
      format.js
    end
  end

  private
    def authenticate
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

    def ensure_permission
      if @member == @job.user
        return
      else
        render json: 'Access denied.', status: 403
      end
    end

    def get_reviewerable
      @reviewerable = @member
    end

    def get_reviewable
      @reviewable = params[:reviewable].classify.constantize.find(reviewable_id)
    end

    def reviewable_id
      params[(params[:reviewable].singularize + '_id').to_sym]
    end

    def set_job
      @job = Job.find(params[:job_id])
    end

    def review_params
      params.require(:review).permit(:quality, :cost, :timeliness, :professionalism, :recommendation, :description)
    end
end
