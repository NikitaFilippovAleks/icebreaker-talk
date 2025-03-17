require 'rails_helper'

RSpec.describe Api::V1::CollectionsController, type: :controller do
  describe 'index' do
    let!(:collection) { create(:collection) }
    let(:send_request) { get :index }

    describe 'content' do
      subject { json_response }

      let(:data_expected) do
        {
          collections:
            [
              {
                id: collection.id,
                name: collection.name,
                description: collection.description,
                color: collection.color,
                questions_count: collection.questions.count
              }
            ]
        }
      end

      before { send_request }

      it { is_expected.to eq data_expected }
    end
  end
end
