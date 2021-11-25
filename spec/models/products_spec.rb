require 'rails_helper'

RSpec.describe "Spree::Products", type: :model do
  subject { product.related_products }

  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product_lists) { create_list(:product, 5, taxons: [taxon]) }

  describe "related_productsメソッド" do
    it do
      is_expected.to eq related_product_lists
    end

    it "商品詳細ページの商品以外を表示すること" do
      is_expected.not_to eq product
    end

    it "表示される商品が重複しないこと" do
      is_expected.to eq related_product_lists.uniq
    end
  end
end
