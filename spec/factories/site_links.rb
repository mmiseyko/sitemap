# frozen_string_literal: true

FactoryBot.define do
  factory :site_link do
    name { Faker::Company.unique.name }

    after(:build) do |site_link|
      while SiteLink.where(name: site_link.name).exists?
        name = Faker::Company.unique.name
        site_link.name = site_link.parent ? name : "/#{name}"
      end

      site_link.relative_path ||= site_link.name.underscore
    end

    trait :with_children do
      after(:build) do |site_link|
        f.children = create_list(:site_link, 2, parent: site_link)
      end
    end
  end
end
