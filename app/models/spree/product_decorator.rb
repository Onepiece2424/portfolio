module Spree::ProductDecorator
  def related_products
    Spree::Product.joins(:taxons).
      distinct.
      in_taxons(taxons).
      where.not(id: id)
  end
  Spree::Product.prepend self
end
