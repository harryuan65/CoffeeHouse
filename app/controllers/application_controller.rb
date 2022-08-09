# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandler

  private

  def check_session
    unless current_user
      flash.now[:alert] = I18n.t("devise.failure.unauthenticated")
      return render "users/sessions/request_session", status: 401
    end
  end

  def show_cart_items_count
    if current_user && !session[:cart_count]
      session[:cart_count] = current_user.current_cart.items.count
    end
  end
end
