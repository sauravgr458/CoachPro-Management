# frozen_string_literal: true

class AddSlugAndEnabledToPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :programs, :slug, :string
    add_column :programs, :enabled, :boolean, default: false

    # Adding database uniquness validation for slug columns
    add_index :programs, :slug, unique: true
    add_index :companies, :slug, unique: true
  end
end
