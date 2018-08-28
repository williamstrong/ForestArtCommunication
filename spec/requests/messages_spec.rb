require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  let!(:person) { create(:person) }
  let!(:messages) { create_list(:message, 10, person_id: person.id) }
  let(:person_id) { person.id }
  let(:message_id) { messages.first.id }

  describe 'GET /persons/:person_id/messages' do
    before { get "/persons/#{person_id}/messages" }

    context 'when person exists' do
      it 'returns messages' do
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when person does not exist' do
      let(:person_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Person/)
      end
    end
  end

  describe 'GET /persons/:person_id/messages/:id' do
    before { get "/persons/#{person_id}/messages/#{message_id}" }

    context 'when the record exists' do
      it 'returns the message' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(message_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:message_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  describe 'POST /persons/:person_id/messages' do
    let(:valid_attributes) { { message_body: 'Body of message', subject: 'A good subject' } }

    context 'when the request is valid' do
      before { post "/persons/#{person_id}/messages", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post "/persons/#{person_id}/messages", params: { subject: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Message body can't be blank/)
      end
    end
  end

  describe 'PUT /persons/:person_id/messages/:id' do
    let(:valid_attributes) { { subject: 'A good subject' } }

    context 'when the record exists' do
      before { put "/persons/#{person_id}/messages/#{message_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /persons/:person_id/messages/:id' do
    before { delete "/persons/#{person_id}/messages/#{message_id}" }

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
