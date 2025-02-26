# frozen_string_literal: true

class AddCoachToCompanyPrograms < ActiveRecord::Migration[6.1]
  def change
    add_column :company_programs, :coach_id, :integer
  end
end
