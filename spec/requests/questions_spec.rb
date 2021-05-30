require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /index" do
    let(:path) { '/questions' }
    let!(:public_questions) { create_list(:question, 5) }
    let!(:private_questions) { create_list(:question, 2, private: true) }
    let(:tenant) { create(:tenant) }

    subject { get path, headers: headers }

    context 'unauthorized request' do
      it 'returns 401' do
        subject
        expect(response.status).to eq(401)
      end
    end

    context 'authorized request' do
      let(:headers) { { 'api-key': tenant.api_key } }
      it 'returns 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'returns list of public questions' do
        subject
        responsed_questions = JSON.parse(response.body)
        expect(responsed_questions.count).to eq(5)
      end
    end
  end
end
