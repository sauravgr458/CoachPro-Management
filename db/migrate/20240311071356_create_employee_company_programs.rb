# frozen_string_literal: true

class CreateEmployeeCompanyPrograms < ActiveRecord::Migration[6.1]
  def change
    create_table :employee_company_programs do |t|
      t.integer :employee_id
      t.integer :company_program_id

      t.timestamps
    end
  end
end
