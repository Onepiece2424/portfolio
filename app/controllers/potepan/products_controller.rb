class Potepan::ProductsController < ApplicationController
  def index
    @products = Spree::Product.all
  end

  def show
    @product = Spree::Product.find(params[:id])
  end
end
