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

  describe 'POST #create' do
    let(:orgtype) { create(:org_type) }
    let(:request_create_org) do
      post :create,
           params: { organization: attributes_for(:organization, org_type_id: orgtype.id) },
           format: :json
    end

    context 'with valid attributes' do
      before { login(staff) }

      it 'saves a new organization in the database' do
        expect { request_create_org }.to change(Organization, :count).by(1)
      end

      it 'render json of new organization' do
        request_create_org

        org_json = OrganizationSerializer.new(Organization.last).to_json

        expect(response).to have_http_status(:created)
        expect(response.body).to eq org_json
      end
    end

    context 'with invalid credentials' do
      it 'does not save new organization when unauthorized' do
        expect { request_create_org }.to_not change(Organization, :count)
      end

      it 'does not save new organization when authorized as Client' do
        login(client)

        expect { request_create_org }.to_not change(Organization, :count)
      end
    end

    context 'with invalid attributes' do
      let(:request_create_org_invalid) do
        post :create,
             params: { organization: attributes_for(:organization,
                                                    :invalid,
                                                    org_type_id: orgtype.id) },
             format: :json
      end

      before { login(staff) }

      it 'does not save new organization' do
        expect { request_create_org_invalid }.to_not change(Organization, :count)
      end

      it 'render json errors' do
        request_create_org_invalid

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(errors: /./)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:organization) { create(:organization) }

    context 'Staff delete organization' do
      before { login(staff) }

      it 'deletes the organization' do
        expect { delete :destroy, params: { id: organization } }.to change(Organization, :count).by(-1)
      end

      it 'return :ok and organiztion' do
        delete :destroy, params: { id: organization }

        expect(response).to have_http_status :ok
        expect(response.body).to have_text organization.name
      end
    end

    context 'Unauthorized user delete organization' do
      before { login(client) }

      it 'but organization does not deletes' do
        expect { delete :destroy, params: { id: organization } }.to_not change(Organization, :count)
      end

      it 'redirect to login page' do
        delete :destroy, params: { id: organization }
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end
end
