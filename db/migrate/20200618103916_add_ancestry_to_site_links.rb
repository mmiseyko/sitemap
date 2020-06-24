# frozen_string_literal: true

class AddAncestryToSiteLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :site_links, :ancestry, :string
    add_index :site_links, :ancestry
  end
end
