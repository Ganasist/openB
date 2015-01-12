class GalleriesController < ApplicationController
  def show
    @contractor = Contractor.find(params[:contractor_id])
    @images = @contractor.uploads.where(after: true).shuffle
  end
end
