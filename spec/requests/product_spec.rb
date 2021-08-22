require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do
    it '10 - 1 は 9 になること' do
      expect(10 - 1).to eq 9
    end
  end
end
