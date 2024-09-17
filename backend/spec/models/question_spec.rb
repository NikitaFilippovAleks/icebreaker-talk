# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question do
  describe 'model columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:text) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }

    it { is_expected.to belong_to(:collection) }
  end

  # Question object creation
  describe '.new' do
    subject { Question.new(attributes) }

    let(:attributes) { attributes_for(:question, params) }
    let(:params) { nil }

    context 'with valid params' do
      it { is_expected.to be_valid }
    end

    context 'with invalid params' do
      context 'when text' do
        context 'with empty value' do
          let(:params) { { text: '' } }

          it do
            is_expected.to has_only_errors_keys(:text)
            is_expected.to has_validation_errors(:text, 'не может быть пустым')
          end
        end

        context 'with nil value' do
          let(:params) { { text: nil } }

          it do
            is_expected.to has_only_errors_keys(:text)
            is_expected.to has_validation_errors(:text, 'не может быть пустым')
          end
        end
      end
    end
  end

  # Question record creation
  describe '.create' do
    subject { Question.find_by(text: attributes[:text]) }

    let(:attributes) { attributes_for(:question, params) }
    let(:params) { nil }

    before { Question.create(attributes) }

    it { is_expected.to be_valid }
  end
end

# == Schema Information
#
# Table name: questions
#
#  id            :uuid             not null, primary key
#  text          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  collection_id :uuid             not null
#
# Indexes
#
#  index_questions_on_collection_id  (collection_id)
#
# Foreign Keys
#
#  fk_rails_...  (collection_id => collections.id)
#
