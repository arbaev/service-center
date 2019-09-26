# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Staff::HomeController, type: :controller do
  let(:staff) { create(:staff) }
  let(:client) { create(:client) }

  describe 'GET #index' do
    context 'authorized as Staff' do
      before do
        login(staff)
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

      it 'returns error when logged as Client' do
        login(client)
        get :index

        expect(response).to have_http_status :found
      end
    end
  end
end
