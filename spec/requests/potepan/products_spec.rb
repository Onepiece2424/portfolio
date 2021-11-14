require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:image) { create(:image) }
  let(:taxonomy) { create(:taxonomy) }
  let(:related_product) { create(:product, taxons: [taxon]) }
  let(:related_product_lists) { create_list(:product, 4, taxons: [taxon]) }

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

  describe '商品詳細ページ、「関連商品(related_product)」部分のテスト(request spec)' do
    it '関連商品(related_product)部分の商品名、価格、画像が表示されること(request spec)' do
      expect(response.body). to include related_product.name
      expect(response.body). to include related_product.display_price.to_s
      expect(response.body). to include rails_blob_path(related_product.images.first.attachment)
    end

    it '関連商品(related_product)の商品が4つ表示されていること(request spec)' do
      expect(related_product_lists.count).to eq 4
    end
  end
end
