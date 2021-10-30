require 'rails_helper'

RSpec.feature "Potepan::Categories", type: :feature do
  given(:taxonomy) { create(:taxonomy) }
  given(:taxon) { create(:taxon) }
  given(:product) { create(:product) }

  background do
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
end
