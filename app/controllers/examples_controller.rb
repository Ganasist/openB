class ExamplesController < ApplicationController
  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  private
  	def example_params
  		params.require(:example).permit(:zip_code, :cost,
		                                  :duration, :duration_unit,
		                                  :description, :image, :delete_image,
		                                  :image_remote_url, { categories: [] })
  	end
end
