# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action -> { flash.clear }

  private

  def render_turbo(template)
    render "turbo/#{template}"
  end
end
