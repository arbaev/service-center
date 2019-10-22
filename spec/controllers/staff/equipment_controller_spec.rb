require 'rails_helper'

RSpec.describe Staff::EquipmentController, type: :controller do
  let(:staff) { create(:staff) }

  describe 'GET #index' do
    let!(:equipments) { create_list(:equipment, 5) }

    context 'authorized as Staff' do
      before do
        login(staff)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'return all Equipments data in json' do
        parsed_response = JSON.parse response.body
        expect(parsed_response['data'].count).to eq equipments.count
      end
    end

    context 'unauthorized' do
      let(:json_error) { { error: 'You need to sign in or sign up before continuing.' } }

      it 'returns error when not logged' do
        get :index

        expect(response).to have_http_status :found
      end
    end
  end
end
