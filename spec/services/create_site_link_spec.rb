# frozen_string_literal: true

require 'rails_helper'

describe CreateSiteLink do
  subject(:service) { described_class }

  describe '.call' do
    let(:home) { { name: 'Home', relative_path: '/' } }
    let(:settings) { { name: 'Settings', relative_path: 'settings', parent: 'Home' } }

    context 'when parent is empty' do
      let(:do_action) { service.call(home) }

      it 'creates link' do
        expect { do_action }.to change { SiteLink.where(home.merge(ancestry: nil)).count }.by(1)
      end

      context 'when parent is present' do
        let(:do_action) { service.call(settings) }

        context 'when parent record does not exist' do
          it 'raises not found error' do
            expect { do_action }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end

        context 'when parent record exist' do
          let(:home_link) { create(:site_link, name: 'Home', relative_path: '/') }
          let(:search_params) { { name: 'Settings', relative_path: 'settings', ancestry: home_link.id.to_s } }

          before { home_link }

          it 'creates link' do
            expect { do_action }.to change { SiteLink.where(search_params).count }.by(1)
          end
        end
      end
    end
  end
end
