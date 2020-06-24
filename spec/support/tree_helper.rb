# frozen_string_literal: true

module Support
  module TreeHelper
    TEST_TREE = [
      { name: 'Home', relative_path: '/home' },
      { name: 'Admin', relative_path: '/admin' },
      { name: 'Users', relative_path: 'users', parent: 'Admin' },
      { name: 'Posts', relative_path: 'posts', parent: 'Admin' },
      { name: 'Settings', relative_path: 'settings', parent: 'Home' },
      { name: 'Company Profile', relative_path: 'company_profile', parent: 'Settings' },
      { name: 'Switches', relative_path: 'switches', parent: 'Settings' },
      { name: 'Help', relative_path: 'help', parent: 'Home' },
      { name: 'Tickets', relative_path: 'tickets', parent: 'Help' },
      { name: 'Create A Ticket', relative_path: 'create', parent: 'Tickets' },
      { name: 'FAQ', relative_path: 'faqs', parent: 'Help' }
    ].freeze

    TREE_JSON = [
      {
        full_path: '/home',
        id: 1,
        link_id: 'home',
        name: 'Home',
        relative_path: '/home',
        children: [
          {
            full_path: '/home/settings',
            id: 5,
            link_id: 'home.settings',
            name: 'Settings',
            relative_path: 'settings',
            children: [
              {
                children: [],
                full_path: '/home/settings/company_profile',
                id: 6,
                link_id: 'home.settings.company profile',
                name: 'Company Profile',
                relative_path: 'company_profile'
              },
              {
                children: [],
                full_path: '/home/settings/switches',
                id: 7,
                link_id: 'home.settings.switches',
                name: 'Switches',
                relative_path: 'switches'
              }
            ]
          },
          {
            full_path: '/home/help',
            id: 8,
            link_id: 'home.help',
            name: 'Help',
            relative_path: 'help',
            children: [
              {
                full_path: '/home/help/tickets',
                id: 9,
                link_id: 'home.help.tickets',
                name: 'Tickets',
                relative_path: 'tickets',
                children:
                  [{
                    full_path: '/home/help/tickets/create',
                    id: 10,
                    link_id: 'home.help.tickets.create a ticket',
                    name: 'Create A Ticket',
                    relative_path: 'create',
                    children: []
                  }]
              },
              {
                full_path: '/home/help/faqs',
                id: 11,
                link_id: 'home.help.faq',
                name: 'FAQ',
                relative_path: 'faqs',
                children: []
              }
            ]
          }
        ]
      },

      {
        full_path: '/admin',
        id: 2,
        link_id: 'admin',
        name: 'Admin',
        relative_path: '/admin',
        children: [
          {
            children: [],
            full_path: '/admin/users',
            id: 3,
            link_id: 'admin.users',
            name: 'Users',
            relative_path: 'users'
          },
          {
            children: [],
            full_path: '/admin/posts',
            id: 4,
            link_id: 'admin.posts',
            name: 'Posts',
            relative_path: 'posts'
          }
        ]
      }
    ].freeze

    def create_test_tree
      TEST_TREE.each do |attrs|
        parent = nil
        if (parent_name = attrs.delete(:parent))
          parent = SiteLink.find_by(name: parent_name)
        end

        SiteLink.create!(attrs.merge(parent: parent))
      end
    end

    def tree_json
      TREE_JSON
    end
  end
end
