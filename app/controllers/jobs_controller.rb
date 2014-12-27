class JobsController < ApplicationController
  respond_to :html
  before_action :set_job, only: [:show, :edit, :update, :destroy, :resume_search,
                                 :mark_as_complete, :mark_as_incomplete, :cancel_job]
  before_action :user_check, only: [:edit, :update, :destroy]
  before_action :block_visitors

  def index
    @jobs = Job.all.order(updated_at: :desc)
                   .page(params[:jobs])
                   .per(10)
    if category = params[:search]
      @jobs = Job.relevant_categories(category)
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
    @job = Job.new
    respond_with(@job)
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
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
  def mark_as_incomplete
    @job.mark_as_incomplete!
    if @job.contractor_id.nil?
      redirect_to current_user, notice: "Your job '#{ @job.title }' has been marked as incomplete."
    elsif @job.review.nil?
      redirect_to new_job_review_path(@job)
    else
      redirect_to edit_job_review_path(@job)
    end
  end

  # make sure current_user owns this job....
  def cancel_job
    # @job = Job.find(params[:id])
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
      unless user_signed_in? || contractor_signed_in?
        redirect_to root_path, alert: 'Sign up or sign in to access open jobs'
      end
    end

    def user_check
      unless current_user == @job.user
        redirect_to :back, alert: 'Access denied.'
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
