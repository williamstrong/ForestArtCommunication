require 'rails_helper'

RSpec.describe 'Persons API', type: :request do
  let!(:persons) { create_list(:person, 10) }
  let(:person_id) { persons.first.id }

  describe 'GET /persons' do
    before { get '/persons' }

    it 'returns persons' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /persons/:id' do
    before { get "/persons/#{person_id}" }

    context 'when the record exists' do
      it 'returns the person' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(person_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:person_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found person' do
        expect(response.body).to match(/Couldn't find Person/)
      end
    end
  end

  describe 'POST /persons' do
    let(:valid_attributes) { { email: 'test@email.com', first_name: 'Will', last_name: "Strong" } }

    context 'when the request is valid' do
      before { post '/persons', params: valid_attributes }

      it 'creates a person' do
        expect(json['first_name']).to eq('Will')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/persons', params: { email: 'Foobar', first_name: "Will"} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure person' do
        expect(response.body).to match(/Validation failed: Last name can't be blank/)
      end
    end
  end

  describe 'PUT /persons/:id' do
    let(:valid_attributes) { { subject: 'A good subject' } }

    context 'when the record exists' do
      before { put "/persons/#{person_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /persons/:id' do
    before { delete "/persons/#{person_id}" }

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
