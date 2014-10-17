class Contractors::RegistrationsController < RegistrationsController

  def update
    @contractor = Contractor.find(current_contractor.id)

    successfully_updated = if needs_password?(@contractor, params)
      @contractor.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:contractor].delete(:current_password)
      @contractor.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @contractor, bypass: true
      redirect_to after_update_path_for(@contractor)
    else
      render "edit"
    end
  end

  protected

    # check if we need password to update user data
    # ie if password or email was changed
    # extend this as needed
    def needs_password?(contractor, params)
      contractor.email != params[:contractor][:email] ||
        params[:contractor][:password].present? ||
        params[:contractor][:password_confirmation].present?
    end
end
