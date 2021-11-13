require 'rails_helper'

RSpec.feature '商品詳細ページ' do
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { create(:image) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy) }
  given(:image) { create(:image) }
  given(:taxonomy) { create(:taxonomy) }
  given(:related_product) { create(:product, taxons: [taxon]) }
  given(:related_product_lists) { create_list(:product, 4, taxons: [taxon])}

  background do
    product.images << image
    visit potepan_product_path(product.id)
  end

  feature '商品詳細（showページ）ページのテスト(feature spec)' do
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
      expect(page).to have_css '.navbar-brand'
    end

    scenario '「一覧ページへ戻る」リンクをクリック後、カテゴリー一覧ページへ移動することを確認するテスト' do
      click_on '一覧ページへ戻る'
      expect(page).to have_current_path potepan_category_path(product.taxons.first.id)
    end
  end

  feature '商品詳細ページ、「関連商品(related_product)」部分のテスト(feature spec)' do
    background do
      related_product.images.push(create(:image))
      related_product_lists.each { |related_product_list| related_product_list.images << create(:image) }
      visit potepan_product_path(product.id)
    end

    scenario '関連商品(related_product)部分の商品名、価格、画像の表示テスト(feature spec)' do
      expect(page).to have_content related_product.name
      expect(page).to have_content related_product.display_price
      related_product.images.each do |image|
        expect(page).to have_selector("img,[src$='#{image.filename}']")
      end
    end

    scenario '関連商品(related_product)の商品名(related_product.name)をクリック後、商品詳細ページへ移動すること' do
      within('.productsContent') do
        click_on related_product.name
      end
      expect(page).to have_current_path potepan_product_path(related_product.id)
    end

    scenario '関連商品(related_product)の商品価格(related_product.display_price)をクリック後、商品詳細ページへ移動すること' do
      click_on related_product.display_price, match: :first
      expect(page).to have_current_path potepan_product_path(related_product.id)
    end

    scenario '関連商品(related_product)が4つ表示されていること(feature spec)' do
      within('.productsContent') do
        expect(page).to have_selector '.productBox', count:4
      end
    end
  end
end
