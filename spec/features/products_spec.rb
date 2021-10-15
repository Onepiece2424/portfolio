require 'rails_helper'

RSpec.feature '商品詳細ページ' do
  given(:product) { create(:product) }
  given(:image) { create(:image) }

  background do
    visit potepan_product_path(product.id)
    product.images << image
  end

  scenario '画像表示テスト(have_selector)' do
    product.images.each do |image|
      expect(page).to have_selector("img,[src$='#{image.filename}']")
    end
  end

  scenario '商品名テスト' do
    expect(page).to have_content product.name
  end

  scenario '商品価格のテスト' do
    expect(page).to have_content product.price
  end

  scenario '商品説明のテスト' do
    expect(page).to have_content product.description
  end
end
