require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:related_product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }
  let(:taxonomy) { create(:taxonomy) }

  before do
    related_product.images << image
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

  describe 'showページの表示（関連商品部分のテスト）' do
    it '関連商品部分の商品名が表示されること' do
      expect(response.body). to include related_product.name
    end

    it '関連商品部分の商品価格が表示されること' do
      expect(response.body). to include related_product.display_price.to_s
    end

    it '関連商品の商品画像が表示されること' do
      expect(response.body). to include rails_blob_path(related_product.images.first.attachment)
    end
  end
end
