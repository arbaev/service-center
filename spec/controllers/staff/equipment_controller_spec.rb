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

  describe 'PATCH #update' do
    let(:equipment) { create(:equipment) }

    before { login(staff) }

    context 'update Equipment association with organization' do
      let(:organization) { create(:organization) }

      it 'assigns organization to equipment' do
        expect(equipment.organization).to eq nil

        patch :update, params: { id: equipment, organization_id: organization, equipment: attributes_for(:equipment) }, format: :json
        equipment.reload

        expect(equipment.organization).to eq organization
      end

      it 'render json of updated equipment' do
        patch :update, params: { id: equipment, organization_id: organization, equipment: attributes_for(:equipment) }, format: :json

        eq_json = EquipmentSerializer.new(Equipment.last).to_json

        expect(response.body).to eq eq_json
      end
    end
  end
end
