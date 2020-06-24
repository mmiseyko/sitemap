# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SiteLinkSerializer do
  subject(:serialized_record) { described_class.new(record, parents: parents).as_json }

  let(:parents) do
    home = create(:site_link, name: 'Home', relative_path: '/')
    [
      home,
      create(:site_link, name: 'Settings', relative_path: 'settings', parent: home)
    ]
  end

  let(:record) do
    build(
      :site_link,
      id: 1,
      relative_path: 'user',
      name: 'User',
      parent: parents.last
    )
  end

  its([:id]) { is_expected.to eq(1) }
  its([:link_id]) { is_expected.to eq('home.settings.user') }
  its([:name]) { is_expected.to eq('User') }
  its([:relative_path]) { is_expected.to eq('user') }
  its([:full_path]) { is_expected.to eq('/settings/user') }
end
