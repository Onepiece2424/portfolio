require 'rails_helper'

RSpec.describe "Spree::Products(model spec)", type: :model do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product_lists) { create_list(:product, 4, taxons: [taxon]) }

  describe "related_productsメソッド" do
    it do
      expect(product.related_products).to eq related_product_lists
    end

    it "商品詳細ページの商品以外を表示すること" do
      expect(product.related_products).not_to eq product
    end

    it "表示される商品が重複しないこと" do
      expect(product.related_products).to eq related_product_lists.uniq
    end
  end
end
