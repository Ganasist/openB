class ReviewsController < ApplicationController
  before_action :set_job
  # before_action :set_review, only: [:edit, :update, :destroy]
  before_action :get_reviewable, only: [:new, :create, :edit, :update]
  before_action :get_reviewerable, only: [:new, :create, :edit, :update]
  # respond_to :html

  def new
    @review = Review.new
    @contractor = @job.contractor
  end

  def create
    @review = Review.create(review_params)
    @review.reviewable = @reviewable
    @review.reviewerable = @reviewerable
    if @review.save
      flash[:notice] = 'Review was successfully created.'
      redirect_to job_review_path(@job)
    else
      # flash[:error] = "#{ @review.errors.full_messages.to_sentence }"
      render 'new', error: "#{ @review.errors.full_messages.to_sentence }"
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

    def get_reviewerable
      @reviewerable = current_user || current_contractor
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
