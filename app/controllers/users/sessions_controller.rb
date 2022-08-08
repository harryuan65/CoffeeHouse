# frozen_string_literal: true

#
# Declared for custom views only
#
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    build_user and super
  end

  # POST /resource/sign_in
  def create
    # uses self.resource to validate
    @success = if (user = warden.authenticate(auth_options))
      respond_to_sign_in user
    else
      respond_to_bad_sign_in
    end
    respond_to do |format|
      format.turbo_stream
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(:user))
    set_flash_message!(:notice, :signed_out) if signed_out
    redirect_to root_path, notice: "Successfully signed out" # flash not working
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  # Make sure resource is a #User for sign in form.
  def build_user
    self.resource = User.new
  end

  def respond_to_sign_in(user)
    self.resource = user
    set_flash_message!(:notice, :signed_in, now: true)
    sign_in(:user, user)
    true
  end

  def respond_to_bad_sign_in
    set_flash_message(:alert, :invalid, scope: "devise.failure", authentication_keys: "Email", now: true)
    build_user
    false
  end
end
