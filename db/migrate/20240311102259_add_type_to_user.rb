# frozen_string_literal: true

class AddTypeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :type, :string
  end
end
