require 'rails_helper'

RSpec.describe Staff::OrgTypeController, type: :controller do

  describe "GET #index" do
    let!(:orgtypes) { create_list(:org_type, 3) }
    before { get :index }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'return all OrgType names in json' do
      parsed_response = JSON.parse response.body
      expect(parsed_response['data'].count).to eq orgtypes.count
    end
  end
end
