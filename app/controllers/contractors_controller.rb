class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_contractor!, except: [:index, :show]
  # before_filter :admin_only, except: :show
  before_action :block_visitors

  def index
    @contractors = Contractor.all
  end

  def show
    puts request.fullpath
    @cats = @contractor.categories
    @close_jobs = Job.near(@contractor.full_address, 100).order(created_at: :desc)
    @array = []
    @close_jobs.each do |cj|
      @array << cj if !(cj.categories & @cats).empty?
      @jobs = Kaminari.paginate_array(@array).page(params[:jobs]).per(10)
    end
  end

  def destroy
    contractor = Contractor.find(params[:id])
    contractor.destroy
    redirect_to contractors_path, notice: 'contractor deleted.'
  end

  private

    def block_visitors
      unless user_signed_in? || contractor_signed_in?
        redirect_to root_path, alert: 'Sign up or sign in to access Contractor profiles'
      end
    end

    def set_contractor
      @contractor = Contractor.find(params[:id])
    end

    # def admin_only
    #   unless current_user && current_user.admin?
    #     redirect_to :back, :alert => 'Access denied.'
    #   end
    # end

    # def secure_params
    #   params.require(:contractor).permit(:role)
    # end
end
