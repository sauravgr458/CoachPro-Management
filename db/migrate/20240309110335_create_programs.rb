# frozen_string_literal: true

class CreatePrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
