class ApplicationController < ActionController::Base
  before_action -> { flash.clear }
end
