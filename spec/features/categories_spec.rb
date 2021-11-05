require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon, taxonomy: taxonomy, parent: taxonomy.root) }
  given(:product) { create(:product, taxons: [taxon]) }
  given(:image) { create(:image) }

  background do
    product.images << image
    visit potepan_category_path(taxon.id)
  end

  scenario 'page内のタイトルが取得できていること' do
    expect(page).to have_title "#{taxon.name} - BIGBAG Store"
  end

  scenario 'page内にHomeリンクが表示されていること' do
    expect(page).to have_link 'Home'
  end

  scenario 'Homeリンクをクリック後、トップページへ移動ができること' do
    find('.breadcrumb', text: 'Home').click
    visit potepan_index_path
  end

  scenario 'page内に文字列「CATEGORIES」「BRAND」が表示されること' do
    expect(page).to have_content taxonomy.taxons.root.name
  end

  scenario 'page内のliタグに文字列「CATEGORIES」「BRAND」が表示されること' do
    expect(page).to have_selector 'li', text: taxonomy.taxons.root.name
  end

  scenario 'page内のh2タグに文字列「CATEGORIES」「BRAND」が表示されること' do
    expect(page).to have_selector 'h2', text: taxon.name
  end

  scenario 'CategoriesまたはBrandをクリックしたら、カテゴリー一覧が表示されること。さらに、カテゴリー件数と商品一覧の商品数が一致すること' do
    find('ul.collapse').click
    taxonomy.taxons.leaves.each do |taxon|
      expect(page).to have_content taxon.name
      expect(page).to have_content taxon.products.count
      expect(page.all('.productBox').count).to eq taxon.products.count
    end
  end

  scenario 'カテゴリー別のページへ移動すること' do
    find('ul.collapse').click
    visit potepan_category_path(taxon.id)
  end

  scenario '商品画像、商品名、商品価格のクリック後、商品詳細ページへ移動すること' do
    find('div.productBox').click
    visit potepan_product_path(product.id)
  end

  scenario 'カテゴリー一覧の商品画像が表示すること' do
    product.images.each do |image|
      expect(page).to have_selector("img,[src$='#{image.filename}']")
    end
  end
end
