class JobsController < ApplicationController
  respond_to :html
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  # before_filter :user_check, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_contractor!, only: :index
  before_action :authenticate_user!, only: [:new, :create]

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

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      flash[:notice] = 'Job was successfully created.'
      redirect_to current_user
    else
      render 'new'
    end
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
                                  :description, :image, :delete_image,
                                  :image_remote_url, { categories: [] })
    end
end
