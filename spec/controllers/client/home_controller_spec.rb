require 'rails_helper'

RSpec.describe Client::HomeController, type: :controller do
  let(:client) { create(:client) }

  describe "GET #index" do
    before do
      login(client)
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
