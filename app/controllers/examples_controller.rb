class ExamplesController < ApplicationController
	before_action :set_example, only: [:show, :edit, :update, :destroy]

	def new
		@contractor = Contractor.find(params[:contractor_id])
		@example = @contractor.examples.build	
	end

	def show
		
	end

	def create
    @example = Example.new(example_params)
    # @example.contractor = current_contractor
    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to @example
    else
      render 'new'
    end
  end

  def update
    @example = example.find(params[:id])
    if @example.update(example_params)
      flash[:notice] = 'example was successfully updated.'
      redirect_to :back, notice: "Your example for '#{ @example.job.title }' has been updated"
    else
      redirect_to :back, alert: "#{ @example.errors.full_messages.to_sentence }"
    end
  end

  def destroy
    @example = example.find(params[:id])
    @job = @example.job
    @example.destroy
    redirect_to current_contractor, notice: "Your example for '#{ @job.title }' has been removed"
  end

  private
  	def set_example
  		@example = Example.find(params[:id])
  	end

  	def example_params
  		params.require(:example).permit(:contractor, :title, :zip_code, 
  																		:description, :duration, :duration_unit,
  																		:cost, { categories: []}, 
  																		:image_before, :delete_image_before, :image_before_remote_url,
																			:image_after, :delete_image_after, :image_after_remote_url )
  	end
end