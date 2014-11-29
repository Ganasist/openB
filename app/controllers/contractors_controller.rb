class ContractorsController < ApplicationController
  before_action :set_contractor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_contractor!, except: [:index, :show]
  before_action :block_visitors

  def index
    @contractors = Contractor.all.order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(10)
    if category = params[:search]
      @contractors = @contractors.relevant_categories(category)
                                 .order(updated_at: :desc)
                                 .page(params[:contractors])
                                 .per(10)                               
    end
  end

  def show
    if (current_contractor == @contractor) && !@contractor.complete_profile?
      @incomplete_profile_message = render_to_string(partial: 'layouts/incomplete_profile_flash')
    end
    @examples = @contractor.examples.includes(:uploads)
                           .order(updated_at: :desc)
                           .page(params[:examples])

    @comments = Comment.where(commentable_type: 'Contractor', commentable_id: @contractor.id)
                       .order(updated_at: :desc)
                       .page(params[:comments])

    @jobs = Job.where('category <@ ARRAY[?]', @contractor.categories)
               .order(updated_at: :desc)
               .near(@contractor.full_address, 50)
               .includes([:user, :uploads])
               .page(params[:jobs]).per(2)
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
