# frozen_string_literal: true

class Employee < User
  has_many :employee_company_programs, dependent: :destroy
  has_many :company_programs, through: :employee_company_programs

  belongs_to :company

  def join_program(company_program)
    employee_company_program = employee_company_programs.find_or_initialize_by(company_program_id: company_program.id)
    employee_company_program.save
  end
end
