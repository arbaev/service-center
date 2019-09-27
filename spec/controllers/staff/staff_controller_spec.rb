# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::StaffController, type: :controller do
  describe 'GET #user' do
    context 'if authenticated staff user' do
      let(:staff) { create(:staff) }

      it 'returns current user json data' do
        login(staff)
        get :user, format: :json

        json_data = {
          data: {
            id: staff.id.to_s,
            attributes: { email: staff.email.to_s }
          },
          links: { logout_link: destroy_staff_session_path }
        }

        expect(JSON.parse response.body).to include_json json_data
      end
    end

    context 'if unauthenticated staff user' do
      let(:client) { create(:client) }

      it 'returns empty json when not logged' do
        get :user, format: :json

        expect(response).to have_http_status :ok
        expect(JSON.parse response.body).to be_empty
      end

      it 'returns empty json when logged as Client' do
        login(client)
        get :user, format: :json

        expect(response).to have_http_status :ok
        expect(JSON.parse response.body).to be_empty
      end
    end
  end
end
