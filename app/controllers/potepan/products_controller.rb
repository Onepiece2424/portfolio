class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.find(params[:id])
    @page_title = "#{@product.name} - BIGBAG Store"
  end
end
