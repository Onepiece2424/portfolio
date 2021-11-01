class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes([:taxons])
    @taxon = Spree::Taxon.find(params[:id])
    @taxon_products = Spree::Product.in_taxons(@taxon).includes(:master, :variants)
    @products = Spree::Product.in_taxons(@taxon).includes(master: :default_price)
  end
end
