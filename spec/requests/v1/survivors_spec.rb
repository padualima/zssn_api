require 'rails_helper'

RSpec.describe 'V1::Survivors', type: :request do
  let(:survivor) { build(:survivor) }

  describe 'POST /create' do
    let(:payload) { api_payload(survivor, [survivor.location_feature]) }

    it 'should create survivor' do
      expect do
        post survivors_path, headers: api_headers, params: payload
      end.to change(Survivor, :count)

      expect(response).to have_http_status(:ok)
    end

    it 'should not create survivor when name not is present' do
      reject_payload(payload, 'name')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Name can't be blank")
    end

    it 'should not create survivor when gender not is present' do
      reject_payload(payload, 'gender')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Gender can't be blank")
      expect(response.parsed_body['errors']['message'][1])
        .to eql("Gender is not included in the list")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location can't be blank")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'latitude', 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location feature latitude can't be blank")
      expect(response.parsed_body['errors']['message'][1])
        .to eql("Location feature latitude is not a number")
    end

    it 'should not create survivor when location is present' do
      reject_payload(payload, 'longitude', 'location_feature_attributes')

      post survivors_path, headers: api_headers, params: payload

      expect(response).to have_http_status(:unprocessable_entity)
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

    it 'should return ok if survivor exists' do
      expect do
        get survivor_path(survivor), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to eql(survivor.id)
      expect(response.parsed_body['name']).to eql(survivor.name)
    end

    it 'should retun not_found if survivor not exists' do
      expect do
        get survivor_path(Survivor.last.id.next), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'PATCH/PUT /update' do
    let(:payload) { api_payload(survivor, [survivor.location_feature]) }
    let(:new_name) { Faker::Name.name }
    let(:new_lat) { Faker::Address.latitude }

    before do
      survivor.save
    end

    it 'should update when survivor is valid' do
      payload['data']['attributes']['name'] = new_name
      payload['data']['attributes']['location_feature_attributes']['latitude'] = new_lat

      expect do
        patch survivor_path(survivor), headers: api_headers, params: payload
      end.to_not change(Survivor, :count)

      survivor.reload

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['id']).to eql(survivor.id)
      expect(response.parsed_body['name']).to eql(survivor.name)
    end

    it 'should not update when survivor not valid' do
      payload['data']['attributes']['name'] = ''
      payload['data']['attributes']['location_feature_attributes']['latitude'] = nil

      expect do
        patch survivor_path(survivor), headers: api_headers, params: payload
      end.to_not change(Survivor, :count)

      survivor.reload

      expect(response.parsed_body['errors']['message'][2])
        .to eql("Name can't be blank")
      expect(response.parsed_body['errors']['message'][0])
        .to eql("Location feature latitude can't be blank")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should not update when survivor was not_found' do
      expect do
        patch survivor_path(Survivor.last.id.next), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /nearest' do
    let(:location) { build(:location_feature, :with_survivor_nearby) }
    let(:nearest_location) { LocationFeature.by_nearby(location).first }
    let(:survivor) { location.survivor }

    before do
      location.save
    end

    it 'should return ok if exists nearest survivor ' do
      location.reload

      expect do
        get nearest_survivor_path(survivor), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['nearest_survivor']['name'])
        .to eql(nearest_location.survivor.name)
    end

    it 'should not update when not exists nearest survivor' do
      nearest_location.destroy

      expect do
        get nearest_survivor_path(survivor), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should retun not_found if survivor not exists' do
      expect do
        get nearest_survivor_path(Survivor.last.id.next), headers: api_headers
      end.to_not change(Survivor, :count)

      expect(response).to have_http_status(:not_found)
    end
  end
end
