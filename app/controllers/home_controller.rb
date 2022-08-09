# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :show_cart_items_count
  def index
    @products = Product.all
  end
end
