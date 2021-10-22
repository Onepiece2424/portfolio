class Potepan::CategoriesController < ApplicationController
  def show
    @taxonomies = Spree::Taxonomy.includes(:root)
    @taxon = Spree::Taxon.find(params[:id])
    @taxon_products = Spree::Product.in_taxons(@taxon).includes(:master, :variants)
  end
end
