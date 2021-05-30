require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /index" do
    let(:path) { '/questions' }
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

      context 'without query params' do
        let!(:public_questions) { create_list(:question, 5) }
        let!(:private_questions) { create_list(:question, 2, private: true) }

        it 'returns 200' do
          subject
          expect(response.status).to eq(200)
        end

        it 'returns list of public questions' do
          subject
          responsed_questions = JSON.parse(response.body)
          expect(responsed_questions.count).to eq(5)
        end

        it 'increases api_call_count by 1' do
          expect { subject }.to change { tenant.reload.api_call_count }.by(1)
        end
      end

      context 'with query params' do
        let(:path) { '/questions?q=hello' }

        it 'returns 404' do
          subject
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
