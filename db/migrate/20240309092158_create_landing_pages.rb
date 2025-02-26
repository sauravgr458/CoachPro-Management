# frozen_string_literal: true

class CreateLandingPages < ActiveRecord::Migration[6.1]
  def change
    create_table :landing_pages do |t|
      t.string :heading
      t.string :description
      t.integer :company_id

      t.timestamps
    end
  end
end
