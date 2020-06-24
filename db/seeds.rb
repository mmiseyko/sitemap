# frozen_string_literal: true

site_links = [
  { name: 'Home', relative_path: '/' },
  { name: 'Settings', relative_path: 'settings', parent: 'Home' },
  { name: 'Company Profile', relative_path: 'company_profile', parent: 'Settings' },
  { name: 'Switches', relative_path: 'switches', parent: 'Settings' },
  { name: 'Help', relative_path: 'help', parent: 'Home' },
  { name: 'Tickets', relative_path: 'tickets', parent: 'Help' },
  { name: 'Create A Ticket', relative_path: 'create', parent: 'Tickets' },
  { name: 'FAQ', relative_path: 'faqs', parent: 'Help' }
]

def find_link!(_name)
  site_links.find_by { |link| link[:name] == parent } # || raise ActiveRecord::RecordNotFound
end

def create_link(attrs)
  parent = nil
  if (parent_name = attrs.delete(:parent))
    parent = SiteLink.find_by(name: parent_name)
  end

  SiteLink.create!(attrs.merge(parent: parent))
end

site_links.each do |site_link|
  CreateSiteLink.call(site_link)
end
