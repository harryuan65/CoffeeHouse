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
    user = warden.authenticate(auth_options)
    if user
      self.user = user
      set_flash_message!(:notice, :signed_in)
      sign_in(:user, user)
      respond_with user, location: after_sign_in_path_for(resource)
    else
      set_flash_message(:alert, :invalid, scope: "devise.failure", authentication_keys: "Email")
      render turbo_stream: turbo_stream.update("flash_messages", partial: "shared/flash")
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
