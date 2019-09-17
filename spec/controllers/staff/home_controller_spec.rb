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
end
