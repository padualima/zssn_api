require 'rails_helper'

RSpec.describe 'V1::Survivors', type: :request do
  let(:survivor) { build(:survivor, :with_location) }

  describe 'POST /create' do
    let(:payload) { api_payload(survivor, [survivor.location_feature]) }

    it 'should create survivor' do
      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(200)
    end

    it 'should not create survivor when name not is present' do
      reject_payload(payload, 'name')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(422)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Name can't be blank")
    end

    it 'should not create survivor when gender not is present' do
      reject_payload(payload, 'gender')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(422)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Gender can't be blank")
      expect(response.parsed_body['errors']['message'][1])
        .to eql("Gender is not included in the list")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(422)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location can't be blank")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'latitude', 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(422)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location feature latitude can't be blank")
      expect(response.parsed_body['errors']['message'][1])
        .to eql("Location feature latitude is not a number")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'longitude', 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(422)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location feature longitude can't be blank")
      expect(response.parsed_body['errors']['message'][1])
        .to eql("Location feature longitude is not a number")
    end
  end

  describe 'GET /show' do
    before do
      survivor.save
    end

    it 'should return ok if survivor exists'
    it 'should retun not_found if survivor not exists'
  end
end
