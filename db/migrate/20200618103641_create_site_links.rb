# frozen_string_literal: true

class CreateSiteLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :site_links do |t|
      t.string :name, null: false
      t.string :relative_path, null: false
      t.timestamps
    end
  end
end
