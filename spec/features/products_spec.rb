require 'rails_helper'

RSpec.feature '商品詳細ページ' do
  given(:product) { create(:product) }
  given(:image) { create(:image) }

  background do
    product.images << image
    visit potepan_product_path(product.id)
  end

  scenario '画像表示テスト(have_selector)' do
    product.images.each do |image|
      expect(page).to have_selector("img,[src$='#{image.filename}']")
    end
  end

  scenario '商品名テスト(div.page-title部分のproduct.nameのテスト)' do
    within(:css, 'div.page-title') do
      expect(page).to have_content product.name
    end
  end

  scenario '商品名テスト(ol.breadcrumb部分のproduct.nameのテスト)' do
    within(:css, 'ol.breadcrumb') do
      expect(page).to have_content product.name
    end
  end

  scenario '商品名テスト(div.media-body部分のproduct.nameのテスト)' do
    within(:css, 'div.media-body') do
      expect(page).to have_content product.name
    end
  end

  scenario '商品価格のテスト' do
    expect(page).to have_content product.price
  end

  scenario '商品説明のテスト' do
    expect(page).to have_content product.description
  end

  scenario 'have_linkを用いた商品リンク(Home)のテスト' do
    expect(page).to have_link 'Home'
  end

  scenario 'have_cssを用いた商品リンク(Home、show.html.erb記載)のテスト' do
    find("section.lightSection").click
    expect(page).to have_css '.breadcrumb'
  end

  scenario 'have_cssを用いた商品リンク(Home、_header.html.erb記載)のテスト' do
    find("div.collapse").click
    expect(page).to have_css '.active'
  end

  scenario '商品リンク(BIGBAG)のテスト' do
    find("div.navbar-header").click
    expect(page).to have_css '.navbar-brand'
  end
end
