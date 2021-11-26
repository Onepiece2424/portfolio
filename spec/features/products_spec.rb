require 'rails_helper'

RSpec.feature '商品詳細部分と関連商品部分のテスト' do
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { create(:image) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy) }
  given(:taxonomy) { create(:taxonomy) }
  given(:related_product) { create(:product, taxons: [taxon]) }
  given(:related_products) { create_list(:product, 4, taxons: [taxon]) }

  background do
    product.images << image
    visit potepan_product_path(product.id)
  end

  feature '商品詳細部分のテスト' do
    scenario '商品画像が表示されること' do
      product.images.all do |image|
        expect(page).to have_selector("img,[src$='#{image.filename}']")
      end
    end

    scenario 'div.page-title部分の商品名が表示されること' do
      within(:css, 'div.page-title') do
        expect(page).to have_content product.name
      end
    end

    scenario 'ol.breadcrumb部分の商品名が表示されること' do
      within(:css, 'ol.breadcrumb') do
        expect(page).to have_content product.name
      end
    end

    scenario 'div.media-body部分の商品名が表示されること' do
      within(:css, 'div.media-body') do
        expect(page).to have_content product.name
      end
    end

    scenario '商品価格が表示されること' do
      expect(page).to have_content product.price
    end

    scenario '商品説明が表示されること' do
      expect(page).to have_content product.description
    end

    scenario 'have_linkを用いた商品リンク(Home)が表示されること' do
      expect(page).to have_link 'Home'
    end

    scenario '商品リンク(Home、show.html.erb部分)が表示されること' do
      find("section.lightSection").click
      expect(page).to have_css '.breadcrumb'
    end

    scenario '商品リンク(Home、_header.html.erb部分)が表示されること' do
      find("div.collapse").click
      expect(page).to have_css '.active'
    end

    scenario '商品リンク(BIGBAG)が表示されること' do
      expect(page).to have_css '.navbar-brand'
    end

    scenario '「一覧ページへ戻る」をクリック後、カテゴリー一覧ページへ移動されること' do
      click_on '一覧ページへ戻る'
      expect(page).to have_current_path potepan_category_path(product.taxons.first.id)
    end
  end

  feature '関連商品部分のテスト' do
    background do
      related_product.images.push(create(:image))
      related_products.each { |related_product| related_product.images << create(:image) }
      visit potepan_product_path(product.id)
    end

    scenario '関連商品の商品名、価格、画像が表示されること' do
      expect(page).to have_content related_product.name
      expect(page).to have_content related_product.display_price
      binding.pry
      related_product.images.all do |image|
        expect(page).to have_selector("img,[src$='#{image.filename}']")
      end
    end

    scenario '関連商品の商品名をクリック後、商品詳細ページへ移動されること' do
      within('.productsContent') do
        click_on related_product.name
      end
      expect(page).to have_current_path potepan_product_path(related_product.id)
    end

    scenario '関連商品の商品価格をクリック後、商品詳細ページへ移動されること' do
      click_on related_product.display_price, match: :first
      expect(page).to have_current_path potepan_product_path(related_product.id)
    end

    scenario '関連商品が4つ表示されること' do
      within('.productsContent') do
        expect(page).to have_selector '.productBox', count: 4
      end
    end
  end
end
