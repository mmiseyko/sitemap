# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SiteLinksController, type: :controller do
  describe '#index' do
    let(:do_action) { get :index }

    before do
      create_test_tree
      do_action
    end

    it 'returns 200 status' do
      expect(response.status).to eq 200
    end

    it 'returns expected json' do
      expect(response_hash).to eq(tree_json)
    end
  end
end
