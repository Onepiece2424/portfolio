require 'rails_helper'

RSpec.feature '商品詳細ページ' do
  given!(:product) { create(:product) }
  given!(:image) { create(:image) }

  before do
    product.images << image
  end

  scenario '画像表示テスト(have_selector)' do
    visit potepan_product_path(product.id)
    product.images.each do |image|
      expect(page).to have_selector("img,[src$='#{image.filename}']")
    end
  end
end
