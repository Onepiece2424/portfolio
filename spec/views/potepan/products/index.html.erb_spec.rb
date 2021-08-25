require 'rails_helper'

# RSpec.describe "products/index.html.erb", type: :view do
RSpec.feature 'トップページの表示' do
  it 'index.html.erbへ行く' do
    visit potepan_products_path
  end
end
