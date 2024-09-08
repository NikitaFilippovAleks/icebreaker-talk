# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collection do
  describe 'model columns' do
    it { is_expected.to have_db_column(:id) }
    it { is_expected.to have_db_column(:color) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:created_at) }
    it { is_expected.to have_db_column(:updated_at) }
  end

  # Collection object creation
  describe '.new' do
    subject { Collection.new(attributes) }

    let(:attributes) { attributes_for(:collection, params) }
    let(:params) { nil }

    context 'with valid params' do
      it { is_expected.to be_valid }
    end

    context 'with invalid params' do
      context 'when name' do
        context 'with empty value' do
          let(:params) { { name: '' } }

          it do
            is_expected.to has_only_errors_keys(:name)
            is_expected.to has_validation_errors(:name, 'не может быть пустым')
          end
        end

        context 'with nil value' do
          let(:params) { { name: nil } }

          it do
            is_expected.to has_only_errors_keys(:name)
            is_expected.to has_validation_errors(:name, 'не может быть пустым')
          end
        end
      end

      context 'when color' do
        context 'with empty value' do
          let(:params) { { color: '' } }

          it do
            is_expected.to has_only_errors_keys(:color)
            is_expected.to has_validation_errors(:color, 'не может быть пустым')
          end
        end

        context 'with nil value' do
          let(:params) { { color: nil } }

          it do
            is_expected.to has_only_errors_keys(:color)
            is_expected.to has_validation_errors(:color, 'не может быть пустым')
          end
        end
      end

      context 'when description' do
        context 'with empty value' do
          let(:params) { { description: '' } }

          it do
            is_expected.to has_only_errors_keys(:description)
            is_expected.to has_validation_errors(:description, 'не может быть пустым')
          end
        end

        context 'with nil value' do
          let(:params) { { description: nil } }

          it do
            is_expected.to has_only_errors_keys(:description)
            is_expected.to has_validation_errors(:description, 'не может быть пустым')
          end
        end
      end
    end
  end

  # Collection record creation
  describe '.create' do
    subject { Collection.find_by(name: attributes[:name]) }

    let(:attributes) { attributes_for(:collection, params) }
    let(:params) { nil }

    before { Collection.create(attributes) }

    it { is_expected.to be_valid }
  end
end

# == Schema Information
#
# Table name: collections
#
#  id          :bigint           not null, primary key
#  color       :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
