class HomeController < ApplicationController
  def index
    @main_categories = Category.take(4)
    @products = Product.where(active: true, category: @main_categories).order(created_at: :desc)
  end
end
