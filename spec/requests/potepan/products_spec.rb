require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/potepan/products"
      expect(response).to have_http_status(:success)
    end
  end
end
