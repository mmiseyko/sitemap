# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
    parent = SiteLink.find_by(name: parent_name) # || create_link(find_link!(parent))
  end

  SiteLink.create!(attrs.merge(parent: parent))
end

site_links.each do |site_link|
  create_link(site_link)
end
