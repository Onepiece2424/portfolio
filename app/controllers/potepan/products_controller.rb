class Potepan::ProductsController < ApplicationController
  MAX_PRODUCTS_COUNT = 4
  def show
    @product = Spree::Product.find(params[:id])
    @related_product = Spree::Product.in_taxons(@product.taxons).
      includes(master: [:default_price, images: [attachment_attachment: :blob]]).
      where.not(id: @product.id).limit(MAX_PRODUCTS_COUNT).distinct
  end
end
