require 'rails_helper'

RSpec.describe "Spree::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/potepan/index"
      expect(response).to have_http_status(:success)
    end
    it "returns a 200 response" do
      get "/potepan/index"
      expect(response).to have_http_status "200"
    end
  end
end
