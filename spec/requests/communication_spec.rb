require 'rails_helper'

RSpec.describe 'Communications API', type: :request do
  describe 'POST /communications'
    let(:valid_attributes) { { email: 'test@email.com',
                               first_name: 'Will',
                               last_name: 'Strong',
                               message_body: 'Body of the message',
                               subject: 'A good subject' } }

    context 'when the request is valid' do
      before { post '/communications', params: valid_attributes }

      it 'creates a communication' do
        expect(json['first_name']).to eq('Will')
      end

      it 'returns status code 201' do
        expect(response).to  have_http_status(201)
      end
    end
end
