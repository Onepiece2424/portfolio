require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon) }
  let(:related_product) { create(:product) }

  before do
    get potepan_product_url product.id
  end

  describe 'showページの表示' do
    it 'レスポンスが返ってくること' do
      expect(response.status).to eq(200)
    end

    it '商品名が表示されること' do
      expect(response.body). to include product.name
    end

    it '商品価格が表示されること' do
      expect(response.body). to include product.price.to_s
    end

    it '商品説明が表示されること' do
      expect(response.body). to include product.description
    end

    it '商品タイトルが存在していること' do
      assert_select "title", "#{product.name} - BIGBAG Store"
    end
  end
end
