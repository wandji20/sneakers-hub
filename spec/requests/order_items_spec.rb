require 'rails_helper'

RSpec.describe "OrderItems", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/order_items/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/order_items/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/order_items/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/order_items/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
