class API::V1::GalleriesController < ApiController
  before_filter :set_contractor
  before_filter :contractor_check, only: :destroy

  def show
    @images = @contractor.uploads.where(after: true).shuffle
    render :show
  end

  private

  def set_contractor
    @contractor = Contractor.find(params[:contractor_id])
  end

  def contractor_check
    unless current_member == @contractor
      redirect_to :back, alert: 'You are not authorised to do that'
    end
  end
end
