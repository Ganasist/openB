class JobsController < ApplicationController
  before_action :set_job, only: [:edit, :update, :destroy, :resume_search,
                                 :mark_as_complete, :cancel_job]

  before_action :user_check, only: [:edit, :update, :destroy, :resume_search,
                                    :mark_as_complete, :cancel_job]

  before_action :new_job_check, only: [:new, :create]

  def index
    @jobs = Job.all.includes(:user).order(updated_at: :desc)
                   .page(params[:jobs])
                   .per(10)
    if category = params[:search]
      @jobs = Job.relevant_categories(category).includes(:user)
                 .searching
                 .order(updated_at: :desc)
                 .page(params[:jobs])
                 .per(10)
    end
  end

  def show
    @job = Job.includes(uploads: :uploadable).find(params[:id])
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

  def resume_search
    @job.resume_search!
    redirect_to @job, notice: "Contractor search for '#{ @job.title }' has been resumed. Please check the job's bids."
  end

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
    def user_check
      unless current_user == @job.user
        redirect_to current_member || root_path, alert: 'Access denied.'
      end
    end

    def new_job_check
      unless user_signed_in?
        redirect_to current_member || root_path, alert: 'Access denied.'
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
