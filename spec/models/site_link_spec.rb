# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteLink, type: :model do
  describe 'validations' do
    before do
      parent = create(:site_link, name: 'Home', relative_path: '/')
      create(:site_link, name: 'Settings', parent: parent, relative_path: 'settings')
    end

    it { is_expected.to validate_presence_of(:relative_path) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:ancestry) }

    describe 'relative_path' do
      subject(:link) { build(:site_link, ancestry: ancestry, relative_path: relative_path) }

      before do
        link.valid?
      end

      context 'when root node' do
        let(:ancestry) { nil }

        context 'when no slash' do
          let(:relative_path) { 'not_root_path' }

          it { expect(link.errors[:relative_path]).to include('invalid_format') }
        end

        context 'when slash presents' do
          let(:relative_path) { '/root_path/path' }

          it { expect(link.errors[:relative_path]).to be_empty }

          context 'when invalid format' do
            let(:relative_path) { '//root_path' }

            it { expect(link.errors[:relative_path]).to include('invalid_format') }
          end
        end
      end

      context 'when child node' do
        let(:ancestry) { '1' }

        context 'when no slash' do
          let(:relative_path) { 'not_root_path/path' }

          it { expect(link.errors[:relative_path]).to be_empty }

          context 'when invalid format' do
            let(:relative_path) { 'not_root_path/path!' }

            it { expect(link.errors[:relative_path]).to include('invalid_format') }
          end
        end

        context 'when slash presents' do
          let(:relative_path) { '/root_path' }

          it { expect(link.errors[:relative_path]).to include('invalid_format') }
        end
      end
    end
  end

  describe '#serialize_tree' do
    before { test_tree }

    it 'returns full tree' do
      expect(described_class.serialize_tree).to eq(tree_json)
    end
  end
end
