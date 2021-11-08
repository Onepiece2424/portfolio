class Potepan::ProductsController < ApplicationController
  MAX_PRODUCTS_COUNT = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_product = Spree::Product.related_products(@product).limit(MAX_PRODUCTS_COUNT)
  end
end
