require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  let(:product) { create(:product, taxons: [taxon]) }
  let(:taxon) { create(:taxon, taxonomy: taxonomy) }
  let(:image) { create(:image) }
  let(:taxonomy) { create(:taxonomy) }
  let(:related_product) { create(:product, taxons: [taxon]) }
  let(:product_lists) { create_list(:product, 5, taxons: [taxon]) }

  before do
    related_product.images << image
    product_lists.each { |product_list| product_list.images << create(:image) }
    get potepan_product_url product.id
  end

  describe '商品詳細ページ' do
    it 'レスポンスが返ってくること' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスに商品名が含まれること' do
      expect(response.body). to include product.name
    end

    it 'レスポンスに商品価格が含まれること' do
      expect(response.body). to include product.price.to_s
    end

    it 'レスポンスに商品説明が含まれること' do
      expect(response.body). to include product.description
    end

    it '商品タイトルが存在していること' do
      assert_select "title", "#{product.name} - BIGBAG Store"
    end
  end

  describe '商品詳細ページ、関連商品部分' do
    it 'レスポンスに関連商品部分の商品名、価格、画像が含まれること' do
      expect(response.body). to include related_product.name
      expect(response.body). to include related_product.display_price.to_s
      expect(response.body). to include rails_blob_path(related_product.images.first.attachment)
    end

    it "関連商品が5つ取得できても、レスポンスに含まれる商品が4つしかないこと" do
      expect(response.body).to include product_lists.first.name
      expect(response.body).to include product_lists.second.name
      expect(response.body).to include product_lists.third.name
      expect(response.body).not_to include product_lists.fifth.name
    end
  end
end
