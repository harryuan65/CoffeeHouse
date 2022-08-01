# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @products = Product.all
  end
end
