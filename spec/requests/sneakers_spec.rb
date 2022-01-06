require 'rails_helper'

RSpec.describe 'Sneakers', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/sneakers/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/sneakers/show'
      expect(response).to have_http_status(:success)
    end
  end
end
