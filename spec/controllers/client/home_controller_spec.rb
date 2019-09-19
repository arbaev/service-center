# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::HomeController, type: :controller do
  let(:client) { create(:client) }

  describe 'GET #index' do
    before do
      login(client)
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #user' do
    it 'returns current user json data' do
      login(client)
      get :user, format: :json

      json_data = {
        data: {
          id: client.id.to_s,
          attributes: { email: client.email.to_s }
        },
        links: { logout_link: destroy_client_session_path }
      }

      expect(JSON.parse response.body).to include_json(json_data)
    end
  end
end
