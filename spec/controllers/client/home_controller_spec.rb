# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::HomeController, type: :controller do
  let(:client) { create(:client) }
  let(:staff) { create(:staff) }

  describe 'GET #index' do
    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do

    context 'with valid attributes' do
      before { login(staff) }

      it 'saves a new client in the database' do
        expect { post :create, params: attributes_for(:client) }.to change(Client, :count).by(1)
      end

      it 'render json of new client' do
        new_client_attrs = attributes_for(:client)

        post :create, params: new_client_attrs

        new_client_attrs.delete(:password)
        new_client_attrs.delete(:password_confirmation)

        expect(response.body).to include_json(data: {
            id: /\d/,
            attributes: new_client_attrs
          })
      end

    end

    context 'with invalid attributes' do
      before { login(staff) }

      it 'does not save new client' do
        expect { post :create, params: attributes_for(:client, :invalid) }.to_not change(Client, :count)
      end

      it 'render json errors' do
        post :create, params: attributes_for(:client, :invalid)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(errors: /./)
      end
    end

    context 'with invalid credentials' do
      it 'does not save new client when unauthorized' do
        expect { post :create, params: attributes_for(:client) }.to_not change(Client, :count)
      end

      it 'does not save new client when authorized as Client' do
        login(client)

        expect { post :create, params: attributes_for(:client) }.to_not change(Client, :count)
      end
    end
  end
end
