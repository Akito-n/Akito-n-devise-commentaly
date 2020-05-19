# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    super if resource.nil? || resource.confirmed?
  end

  def confirm
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token])
    if resource.update(confirm_params) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in resource
      redirect_to root_path
    else
      render :show
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

  private 
  def confirm_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
