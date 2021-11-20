require 'rails_helper'

RSpec.describe "Spree::Products(model spec)", type: :model do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product1) { create(:product, taxons: [taxon]) }
  let(:related_product2) { create(:product, taxons: [taxon]) }
  let(:related_product3) { create(:product, taxons: [taxon]) }
  let(:related_product4) { create(:product, taxons: [taxon]) }
  let(:related_product_lists) { create_list(:product, 4, taxons: [taxon]) }
  let(:related_5products) { create_list(:product, 5, taxons: [taxon]) }

  describe "related_productsメソッドのテスト" do
    it "related_productsメソッドを用いた関連商品に個々の商品を含んでいること" do
      expect(product.related_products).to include related_product1
      expect(product.related_products).to include related_product2
      expect(product.related_products).to include related_product3
      expect(product.related_products).to include related_product4
    end

    it "related_productsメソッドを用いて、商品詳細ページの商品以外を表示すること" do
      expect(product.related_products).not_to eq product
    end

    it "related_product_listsの中に、related_productsメソッドを用いて取得した関連商品を取得できていること" do
      expect(product.related_products).to eq related_product_lists
    end
  end
end
