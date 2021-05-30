require 'rails_helper'

RSpec.describe "Questions", type: :request do
  describe "GET /index" do
    let(:path) { '/questions' }
    let!(:public_questions) { create_list(:question, 5) }
    let!(:private_questions) { create_list(:question, 2, private: true) }

    it 'returns 200' do
      get path
      expect(response.status).to eq(200)
    end

    it 'returns list of public questions' do
      get path
      responsed_questions = JSON.parse(response.body)
      expect(responsed_questions.count).to eq(5)
    end
  end
end
