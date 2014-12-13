class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @job = Job.find(params[:job_id])
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    @job = Job.find(params[:job_id])
    @review = Review.find(params[:id])
    respond_with(@review)
  end

  def new
    @job = Job.find(params[:job_id])
    @contractor = @job.contractor
    @review = Review.new
    respond_with(@review)
  end

  def edit
    @job = Job.find(params[:job_id])
    @contractors = @job.bids.contractors.to_a
    @review = Review.new
    respond_with(@review)
  end

  def create
    @job = Job.find(params[:job_id])
    @review = @job.reviews.new(review_params)
    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_to job_review_path(@job, @review)
    else
      flash[:error] = 'Review could not be created.'
      render 'new'
    end
  end

  def update
    flash[:notice] = 'Review was successfully updated.' if @review.update(review_params)
    respond_with(@review)
  end

  def destroy
    @review.destroy
    respond_with(@review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:description, :job_id)
    end
end
