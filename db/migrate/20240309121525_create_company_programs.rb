# frozen_string_literal: true

class CreateCompanyPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :company_programs do |t|
      t.integer :company_id
      t.integer :program_id

      t.timestamps
    end
  end
end
