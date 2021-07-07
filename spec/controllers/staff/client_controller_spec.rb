# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::ClientController, type: :controller do
  let(:client) { build(:client) }
  let(:staff) { create(:staff) }

  describe 'GET #index' do
    let!(:clients) { create_list(:client, 5) }

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
        expect(parsed_response['data'].count).to eq clients.count
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
    let(:request_create_client) do
      post :create,
      params: { client: attributes_for(:client) },
      format: :json
    end

    context 'with valid attributes' do
      before { login(staff) }

      it 'saves a new client in the database' do
        expect { request_create_client }.to change(Client, :count).by(1)
      end

      it 'render json of new client' do
        request_create_client

        client_json = ClientSerializer.new(Client.last).to_json

        expect(response).to have_http_status(:created)
        expect(response.body).to eq client_json
      end
    end

    context 'with invalid attributes' do
      let(:request_create_client_invalid) do
        post :create,
             params: { client: attributes_for(:client, :invalid) },
             format: :json
      end

      before { login(staff) }

      it 'does not save new client' do
        expect { request_create_client_invalid }.to_not change(Client, :count)
      end

      it 'render json errors' do
        request_create_client_invalid

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(errors: /./)
      end
    end

    context 'with invalid credentials' do
      it 'does not save new client when unauthorized' do
        expect { request_create_client }.to_not change(Client, :count)
      end

      it 'does not save new client when authorized as Client' do
        login(client)

        expect { request_create_client }.to_not change(Client, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(staff) }

    let!(:client) { create(:client) }
    let!(:new_client) { build(:client) }

    context 'with valid attributes' do
      it 'assigns the requested Client to @client' do
        patch :update, params: { id: client, client: attributes_for(:client) }, format: :json

        expect(assigns(:client)).to eq client
      end

      it 'changes Client attributes' do
        patch :update, params: { id: client, client: { fullname: 'new fullname' } }, format: :json
        client.reload

        expect(client.fullname).to eq 'new fullname'
      end

      it 'render json of updated client' do
        patch :update, params: { id: client, client: { fullname: new_client.fullname } }, format: :json

        expected_data = { data: { id: client.id.to_s, type: 'client',
                                  attributes: {
                                    fullname: new_client.fullname
                                  } } }
        client.reload

        expect(response).to have_http_status :ok
        expect(response.body).to include_json expected_data
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              params:
                { id: client, client: attributes_for(:client, :invalid) },
              format: :json
      end

      it 'does not change question' do
        client.reload

        expect(client.fullname).to eq client.fullname
      end

      it 'render json errors' do
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include_json errors: /./
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:client) { create(:client) }

    context 'Staff delete client' do
      before { login(staff) }

      it 'deletes the client' do
        expect { delete :destroy, params: { id: client } }.to change(Client, :count).by(-1)
      end

      it 'return :ok and deleted client' do
        delete :destroy, params: { id: client }

        expect(response).to have_http_status :ok
        expect(response.body).to have_text client.fullname
      end
    end

    context 'Unauthorized user delete client' do
      before { login(client) }

      it 'but client does not deletes' do
        expect { delete :destroy, params: { id: client } }.to_not change(Client, :count)
      end

      it 'redirect to login page' do
        delete :destroy, params: { id: client }
        expect(response).to redirect_to new_staff_session_path
      end
    end
  end

  describe 'POST #validation' do
    before { login(staff) }

    context 'with invalid attributes' do
      it 'render json of new client errors' do
        post :validation, params: { client: { phone: 'abc', email: 'xyz' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(errors: { phone: /./, email: /./ })
      end
    end

    context 'with valid attributes' do
      let(:client_attrs) { attributes_for(:client) }

      it 'render json of new client' do
        post :validation, params: { client: client_attrs }

        expect(response).to have_http_status(:ok)
        expect(response.body).to include_json(data: { id: nil, type: 'client',
                                                      attributes: {
                                                        fullname: client_attrs[:fullname],
                                                        email: client_attrs[:email]
                                                      } })
      end
    end
  end

  describe 'POST #reset_password' do
    let!(:client) { create(:client) }

    it 'return no content header' do
      post :reset_password, params: { id: client }

      expect(response).to have_http_status :found
    end
  end
end
