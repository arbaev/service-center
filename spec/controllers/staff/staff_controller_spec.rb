# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::StaffController, type: :controller do
  let!(:staffs) { create_list(:staff, 5) }
  let(:client) { build(:client) }
  let(:staff) { staffs.sample }

  describe 'GET #index' do
    context 'authorized as Staff' do
      before do
        login(staff)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'return all Clients data in json' do
        parsed_response = JSON.parse response.body
        expect(parsed_response['data'].count).to eq staffs.count
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
    let(:request_create_staff) do
      post :create,
           params: {staff: attributes_for(:staff) },
           format: :json
    end

    context 'with valid attributes' do
      before { login(staff) }

      it 'saves a new Staff user in the database' do
        expect { request_create_staff }.to change(Staff, :count).by(1)
      end

      it 'render json of new Staff user' do
        request_create_staff

        staff_json = StaffSerializer.new(Staff.last).to_json

        expect(response).to have_http_status(:created)
        expect(response.body).to eq staff_json
      end
    end

    context 'with invalid credentials' do
      it 'does not save new Staff user when unauthorized' do
        expect { request_create_staff }.to_not change(Staff, :count)
      end

      it 'does not save new Staff user when authorized as Client' do
        login(client)

        expect { request_create_staff }.to_not change(Staff, :count)
      end
    end

    context 'with invalid attributes' do
      let(:request_create_staff_invalid) do
        post :create,
             params: { staff: attributes_for(:staff, :invalid) },
             format: :json
      end

      before { login(staff) }

      it 'does not save new Staff user' do
        expect { request_create_staff_invalid }.to_not change(Staff, :count)
      end

      it 'render json errors' do
        request_create_staff_invalid

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(errors: /./)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(staff) }

    let!(:staff_attrs) { attributes_for(:staff) }

    context 'with valid attributes' do
      before do
        patch :update, params: { id: staff, staff: staff_attrs }, format: :json
      end

      it 'assigns the requested Staff to @staff' do
        expect(assigns(:staff)).to eq staff
      end

      it 'changes Staff attributes' do
        staff.reload

        expect(staff.email).to eq staff_attrs[:email]
      end

      it 'render json of updated Staff user' do
        expected_data = { data: { id: staff.id.to_s, type: 'staff',
                                  attributes: {
                                      email: staff_attrs[:email]
                                  } } }
        staff.reload

        expect(response).to have_http_status :ok
        expect(response.body).to include_json expected_data
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              params:
                  { id: staff, staff: attributes_for(:staff, :invalid) },
              format: :json
      end

      it 'does not change question' do
        old_email = staff.email
        staff.reload

        expect(staff.email).to eq old_email
      end

      it 'render json errors' do
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include_json errors: /./
      end
    end
  end

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

  describe 'POST #reset_password' do
    it 'return no content header' do
      post :reset_password, params: { id: staff }

      expect(response).to have_http_status :success
    end
  end
end
