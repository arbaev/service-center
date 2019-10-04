# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::OrganizationController, type: :controller do
  let(:staff) { create(:staff) }
  let(:client) { create(:client) }

  describe 'GET #index' do
    let!(:organizations) { create_list(:organization, 5) }

    context 'authorized as Staff' do
      before do
        login(staff)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'return all Organizations data in json' do
        parsed_response = JSON.parse response.body
        expect(parsed_response['data'].count).to eq organizations.count
      end
    end

    context 'unauthorized' do
      let(:json_error) { { error: 'You need to sign in or sign up before continuing.' } }

      it 'returns error when not logged' do
        get :index

        expect(response).to have_http_status :found
      end

      it 'returns error when logged as Client' do
        login(client)
        get :index

        expect(response).to have_http_status :found
      end
    end
  end
end
