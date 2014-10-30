class JobsController < ApplicationController
  respond_to :html
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :update, :destroy]
  before_action :block_visitors

  def index
    @jobs = Job.all
    respond_with(@jobs)
  end

  def show
    respond_with(@job)
  end

  def new
    @job = Job.new
    respond_with(@job)
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
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
      flash[:notice] = 'Job was successfully updated.'
      respond_with(@job)
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
      params.require(:job).permit(:zip_code, :phone, :title,
                                  :bidding_period, :duration, :duration_unit,
                                  :description, :image, :delete_image,
                                  :image_remote_url, { categories: [] })
    end
end
