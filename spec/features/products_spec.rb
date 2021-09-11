require 'rails_helper'

RSpec.describe 'Products', type: :feature do
  scenario 'トップページのタイトルが適切かどうかの確認' do
    visit potepan_index_path
    expect(page).to have_title 'Potepan'
  end
end
