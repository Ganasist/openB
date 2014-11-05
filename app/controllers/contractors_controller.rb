class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_contractor!, except: [:index, :show]
  # before_filter :admin_only, except: :show
  before_action :block_visitors

  def index
    @contractors = Contractor.all
    if category = params[:search]
      @contractors = @contractors.relevant_categories(category)
                                 .order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(20)
    end
  end

  def show
    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end
    @examples = @contractor.examples
                           .order(updated_at: :desc)
                           .page(params[:examples])

    @jobs = Job.near(@contractor.full_address, 100)
               .order(updated_at: :desc)
               .includes(:user)
               .relevant_categories(@contractor.categories)
               .page(params[:jobs])
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
