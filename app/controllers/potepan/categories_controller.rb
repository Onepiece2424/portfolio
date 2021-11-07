class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes([:taxons])
    @taxon = Spree::Taxon.find(params[:id])
    @products = Spree::Product.in_taxons(@taxon).
      includes(master: [:default_price, images: [attachment_attachment: :blob]])
  end
end
