# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def check_session
    unless current_user
      flash.now[:alert] = I18n.t("devise.failure.unauthenticated")
      return render "users/sessions/request_session", status: 401
    end
  end
end
