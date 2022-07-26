# frozen_string_literal: true

#
# Declared for custom views only
#
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = warden.authenticate(auth_options) # use #resource to validate
    if user
      self.resource = user
      set_flash_message!(:notice, :signed_in)
      sign_in(:user, user)
      # Cannot do redirect for modal because it throws frame target not found, Issue: https://github.com/hotwired/turbo/issues/432
      # respond_with user, location: after_sign_in_path_for(user) # /
      # redirect_to root_path
      render turbo_stream: turbo_stream.update("header", partial: "shared/header")
    else
      set_flash_message(:alert, :invalid, scope: "devise.failure", authentication_keys: "Email")
      render :new
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(:user))
    set_flash_message!(:notice, :signed_out) if signed_out
    render turbo_stream: turbo_stream.update("header", partial: "shared/header")
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
