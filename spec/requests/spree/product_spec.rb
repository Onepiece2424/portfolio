require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  it '10 - 1 は 9 になること' do
    expect(10 - 1).to eq 9
  end
end
