require 'rails_helper'

RSpec.describe "Spree::Taxon,Spree::Taxonomy", type: :request do
  let(:taxonomy) { create(:taxonomy) }
  let(:taxon) { create(:taxon) }
  let(:product) { create(:product, taxons: [taxon]) }
  let(:image) { create(:image) }

  before do
    product.images << image
    get potepan_category_url taxon.id
  end

  describe 'カテゴリー別商品一覧のページ表示' do
    it 'レスポンスが返ってくること' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスに「CATEGORIES」「BRAND」などの文字列が含まれること' do
      expect(response.body). to include taxon.taxonomy.name
    end

    it 'レスポンスにカテゴリー別商品一覧の商品名が含まれること' do
      expect(response.body). to include product.name
    end

    it 'レスポンスにカテゴリー別商品一覧の商品価格が含まれること' do
      expect(response.body). to include product.display_price.to_s
    end

    it 'レスポンスに左サイドバーの商品カテゴリーの一覧が含まれること' do
      taxonomy.taxons.leaves.each do |taxon|
        expect(response.body).to include taxon.name
      end
    end

    it 'レスポンスにカテゴリー別商品一覧の商品画像が含まれること' do
      expect(response.body).to include rails_blob_path(product.images.first.attachment)
    end

    it '商品タイトルが存在していること' do
      assert_select "title", "#{taxon.name} - BIGBAG Store"
    end
  end
end
