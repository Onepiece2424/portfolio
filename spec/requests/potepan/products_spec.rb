require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  let!(:product) { create(:product) }
  before do
    get "/products/#{product.id}"
  end

  describe 'showページの表示' do
    it 'リクエスト200が返ってくるかどうか確認' do
      expect(response.status).to eq(200)
    end

    it '商品名が表示されること' do
      expect(response.body). to include product.name
    end

    it '商品価格が表示されること' do
      expect(response.body). to include product.price.to_s
    end

    it '商品名が表示されること' do
      expect(response.body). to include product.description
    end
  end
end
