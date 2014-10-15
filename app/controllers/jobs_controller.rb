class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_filter :user_check, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_contractor!, only: :index
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @jobs = Job.all
    # respond_with(@jobs)
  end

  def show
    # respond_with(@job)
  end

  def new
    @job = Job.new
    # respond_with(@job)
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    flash[:notice] = 'Job was successfully created.' if @job.save
    # respond_with(@job)
  end

  def update
    flash[:notice] = 'Job was successfully updated.' if @job.update(job_params)
    # respond_with(@job)
  end

  def destroy
    @job.destroy
    # respond_with(@job)
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
      params.require(:job).permit(:title, :description, :zip_code, :user_id, :contractor_id)
    end
end
