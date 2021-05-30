require 'rails_helper'

describe GetQuestionsService do
  let(:service) { described_class.new(query_params) }
  subject { service.call }

  context 'without query' do
    let!(:available_questions) { create_list(:question, 5) }
    let!(:private_questions) { create_list(:question, 2, private: true) }
    let(:query_params) { nil }

    it { is_expected.to eq(true) }
    it 'returns all available questions' do
      subject
      expect(service.data).to match_array(available_questions)
    end
  end

  context 'with query params' do
    let!(:matched_question) { create(:question, title: 'this title contain keyword') }
    let!(:question) { create(:question, title: 'not matched') }

    context 'with matched query' do
      let(:query_params) { 'keyword' }

      it { is_expected.to eq(true) }
      it 'returns matched question' do
        subject
        expect(service.data).to contain_exactly(matched_question)
      end
    end

    context 'with not matched query params' do
      let(:query_params) { 'query' }

      it { is_expected.to eq(false) }
    end
  end
end
