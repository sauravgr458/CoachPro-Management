# frozen_string_literal: true

class AddInvitationIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :invitation_id, :integer
  end
end
