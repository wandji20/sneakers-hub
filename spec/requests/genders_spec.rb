require 'rails_helper'

RSpec.describe "Genders", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/genders/index"
      expect(response).to have_http_status(:success)
    end
  end

end
