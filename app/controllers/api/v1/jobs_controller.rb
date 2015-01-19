class API::V1::JobsController < API::ApiController
  before_action :set_job, only: [:show, :edit, :update, :destroy,
                                 :resume_search, :mark_as_complete, :cancel_job]
    before_action :user_check, only: [:edit, :update, :destroy]
    before_action :block_visitors

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
      @bids = @job.bids.where(rejected: false)
                  .order(updated_at: :desc)
                  .page(params[:bids])
                  .per(5)
    end

    def new
      @job = current_user.jobs.build
    end

    def create
      @job = current_user.jobs.new(job_params)
      if @job.save
        JobMailer.create(@job).deliver_later
        flash[:notice] = 'Job was successfully created.'
        redirect_to @job
      else
        render 'new'
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

    def block_visitors
      # THIS NEEDS TO BE FIXED FOR DEVISE
      # unless user_signed_in? || contractor_signed_in?
      #   render json: { message: 'Sign up or sign in to access open jobs' }, status: 401
      # end
    end

    def user_check
      unless current_user == @job.user
        render json: { message: 'Access denied' }, status: 403
      end
    end

    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:state, :address, :longitude, :latitude, :phone,
                                  :title, :bidding_period, :description, { categories: [] })
    end
  end
