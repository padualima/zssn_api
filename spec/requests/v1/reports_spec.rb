require 'rails_helper'

RSpec.describe "V1::Reports", type: :request do
  describe 'GET /stats' do
    before do
      create_list(:survivor, 4)
    end

    it 'should return ok stats' do
      get stats_reports_path, headers: api_headers

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['survivors'].count).to be(4)
    end
  end
end
