# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::HomeController, type: :controller do
  let(:staff) { create(:staff) }

  describe 'GET #index' do
    before do
      login(staff)
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
      login(staff)
      get :user, format: :json

      json_data = {
        data: {
          id: staff.id.to_s,
          attributes: { email: staff.email.to_s }
        },
        links: { logout_link: destroy_staff_session_path }
      }

      expect(JSON.parse response.body).to include_json(json_data)
    end
  end
end
