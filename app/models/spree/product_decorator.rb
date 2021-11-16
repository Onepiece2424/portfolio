module Spree::ProductDecorator
  def self.prepended(base)
    base.scope :related_products, ->(product) {
      in_taxons(product.taxons).
        includes(master: [:default_price, images: [attachment_attachment: :blob]]).
        where.not(id: product.id).distinct
    }
  end
  Spree::Product.prepend self
end
