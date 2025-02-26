# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeeCompanyProgram, type: :model do
  let(:employee_company_program) { described_class.new }
  let(:company) { create(:company) }
  let(:employee) { create(:employee) }
  let(:company_program) { create(:company_program, company: company) }

  describe 'associations' do
    context 'employee' do
      relation = described_class.reflect_on_association(:employee)
      it { expect(relation.macro).to eq :belongs_to }
    end

    context 'company_program' do
      relation = described_class.reflect_on_association(:company_program)
      it { expect(relation.macro).to eq :belongs_to }
    end
  end

  describe 'validations' do
    xcontext 'with invalid details' do
      it 'validates uniqueness of employee scoped to company_program' do
        existing_employee_company_program = create(:employee_company_program, company_program: company_program,
                                                                              employee: employee)
        employee_company_program.employee = existing_employee_company_program.employee
        employee_company_program.company_program = existing_employee_company_program.company_program

        expect(employee_company_program).not_to be_valid
      end
    end
  end
end
