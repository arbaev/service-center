# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::ClientController, type: :controller do
  describe 'GET #user' do
    context 'if authenticated client user' do
      let(:client) { create(:client) }

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

    context 'if unauthenticated client user' do
      let(:staff) { create(:staff) }
      let(:json_error) { { error: 'You need to sign in or sign up before continuing.' } }

      it 'returns error when not logged' do
        get :user, format: :json

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse response.body).to include_json json_error
      end

      it 'returns error when logged as Staff' do
        login(staff)
        get :user, format: :json

        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse response.body).to include_json json_error
      end
    end
  end
end
