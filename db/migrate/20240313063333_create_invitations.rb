# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
