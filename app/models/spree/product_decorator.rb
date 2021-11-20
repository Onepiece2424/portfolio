module Spree::ProductDecorator
  def related_products
    Spree::Product.joins(:taxons).
      includes(master: [:default_price, images: [attachment_attachment: :blob]]).
      select('spree_products.*, spree_products_taxons.taxon_id').
      distinct.
      in_taxons(:taxons).
      where.not(id: id).
      order(:taxon_id)
  end
  Spree::Product.prepend self
end
