class ContractorsController < ApplicationController
  before_filter :authenticate_contractor!, except: [:index, :show]
  # before_filter :admin_only, except: :show
  before_filter :authenticate_user!, only: [:index, :show]

  def index
    @contractors = Contractor.all
  end

  def show
    @contractor = Contractor.find(params[:id])
    unless current_user && current_user.admin?
      unless @contractor == current_contractor
        redirect_to :back, alert: 'Access denied.'
      end
    end
  end

  def update
    @contractor = Contractor.find(params[:id])
    if @uscontractorer.update_attributes(secure_params)
      redirect_to contractors_path, notice: 'contractor updated.'
    else
      redirect_to contractors_path, alert: 'Unable to update contractor.'
    end
  end

  def destroy
    contractor = Contractor.find(params[:id])
    contractor.destroy
    redirect_to contractors_path, notice: 'contractor deleted.'
  end

  private

  def admin_only
    unless current_user && current_user.admin?
      redirect_to :back, :alert => 'Access denied.'
    end
  end

  def secure_params
    params.require(:contractor).permit(:role)
  end
end
