# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client::HomeController, type: :controller do
  let(:client) { create(:client) }
  let(:staff) { create(:staff) }

  describe 'GET #index' do
    context 'authorized as Client' do
      before do
        login(client)
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    context 'unauthorized' do
      it 'returns error when not logged' do
        get :index

        expect(response).to have_http_status :found
      end

      it 'returns error when logged as Staff' do
        login(staff)
        get :index

        expect(response).to have_http_status :found
      end
    end
  end
end
