# frozen_string_literal: true

class AddCompanyIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company_id, :integer
  end
end
