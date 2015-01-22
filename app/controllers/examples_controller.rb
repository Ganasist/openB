class ExamplesController < ApplicationController
	before_action :set_example, only: [:show, :edit, :update, :destroy]

  def show

  end

	def new
		@example = Example.new
	end

	def create
    @contractor = current_contractor
    @example = @contractor.examples.build(example_params)
    if @example.save
      flash[:notice] = 'Example was successfully created.'
      redirect_to example_path(@example)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @example = Example.find(params[:id])
    if @example.update(example_params)
      flash[:notice] = 'example was successfully updated.'
      redirect_to example_path(@example), notice: "Your example '#{ @example.title }' has been updated"
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
  		params.require(:example).permit(:address, :longitude, :latitude, :title, :description,
                                      :duration, :duration_unit, :cost, { categories: [] })
  	end
end
