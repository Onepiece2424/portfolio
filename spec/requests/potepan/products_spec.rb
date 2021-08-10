# require 'rails_helper'

RSpec.describe "Potepan::Products", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/potepan/products/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/potepan/products/create"
      expect(response).to have_http_status(:success)
    end
  end

end
