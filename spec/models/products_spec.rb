require 'rails_helper'

RSpec.describe "Spree::Products(model spec)", type: :model do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product_lists) { create_list(:product, 4, taxons: [taxon]) }

  describe "related_productsメソッドのテスト" do
    it "related_product_listsの中に、related_productsメソッドを用いて取得した関連商品を取得できていること" do
      expect(product.related_products).to eq related_product_lists
    end

    it "related_productsメソッドを用いて、商品詳細ページの商品以外を表示すること" do
      expect(product.related_products).not_to eq product
    end

    it "表示される商品が重複しないこと（関連商品が5つ取得できても、表示される商品が4つしかないこと）" do
      expect(product.related_products).to eq related_product_lists.uniq
    end
  end
end
