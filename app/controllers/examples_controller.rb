class ExamplesController < ApplicationController
	before_action :set_example, only: [:show, :edit, :update, :destroy]

  def show
    
  end

	def new
		@contractor = Contractor.find(params[:contractor_id])
		@example = @contractor.examples.build	
	end

	def create
    @contractor = Contractor.find(params[:contractor_id])
    @example = @contractor.examples.create(example_params)
    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to contractor_example_path(current_contractor, @example)
    else
      render 'new'
    end
  end

  def edit
  	@contractor = Contractor.find(params[:contractor_id])
  end

  def update
    @example = Example.find(params[:id])
    if @example.update(example_params)
      flash[:notice] = 'example was successfully updated.'
      redirect_to contractor_example_path(current_contractor, @example), notice: "Your example '#{ @example.title }' has been updated"
    else
      render 'edit'
    end
  end

  def destroy
    @example.destroy
    respond_to do |format|
      format.html { redirect_to current_contractor, notice: "Your example '#{ @example.title }' has been removed" }
      format.js
    end
  end

  private
  	def set_example
  		@example = Example.find(params[:id])
  	end

  	def example_params
  		params.require(:example).permit(:title, :description, :duration, 
  																		:duration_unit, :cost, { category: [] })
  	end
end