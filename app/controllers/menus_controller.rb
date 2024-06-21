class MenusController < ApplicationController
  def show
    @main_categories = Category.all
    @products = Product.all
  end
end
