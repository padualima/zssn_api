require 'rails_helper'

RSpec.describe 'V1::Survivors::Records', type: :request do
  let(:reported_survivor) { create(:survivor, :with_nearest_survivor) }
  let(:by_survivor) { reported_survivor.nearest_survivor }
  let(:record) { build(:record) }
  let(:payload) { api_payload(record) }
  let(:invalid_attributes) { { data: { attributes: { name: Faker::Name.name } } } }

  describe "POST /create" do
    context "with valid parameters" do
      before do
        payload['data']['attributes']['survivor_id'] = reported_survivor.id
        payload['data']['attributes']['by_survivor_id'] = by_survivor.id
      end

      it "creates a new Record" do
        expect do
          post survivor_records_path(reported_survivor),
            params: payload.as_json, headers: api_headers
        end.to change(Record, :count).by(1)
      end

      it "renders a JSON response with the new record" do
        post survivor_records_path(reported_survivor), params: payload, headers: api_headers

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Record" do
        expect { post survivor_records_path(reported_survivor), params: invalid_attributes }
          .to change(Record, :count).by(0)
      end

      it "renders a JSON response with errors for the new record" do
        post survivor_records_path(reported_survivor),
             params: invalid_attributes,
             headers: api_headers

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
