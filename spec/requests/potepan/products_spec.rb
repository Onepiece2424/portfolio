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
    
    it '商品画像が取得できること' do
      product.images.each do |display_image|
        expect(response.body). to eq display_image.attachment(:product)
      end
    end
  end
end
