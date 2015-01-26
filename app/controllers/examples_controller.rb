class ExamplesController < ApplicationController
	before_action :set_example, only: [:show, :edit, :update, :destroy]
	before_action :verify_contractor, except: [:new, :create, :show]
	before_action :verify_new_example, only: [:new, :create]

  def show

  end

	def new
		@example = Example.new
	end

	def create
    @contractor = current_contractor
    @example = @contractor.examples.build(example_params)
    if @example.save
      redirect_to @example, notice: 'Example was successfully created'
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

		def verify_contractor
			unless current_contractor == @example.contractor
				redirect_to current_member, alert: 'Access denied'
			end
		end

		def verify_new_example
			unless contractor_signed_in?
				redirect_to current_member || root_path, alert: 'Access denied'
			end
		end
end
