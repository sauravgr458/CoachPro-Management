# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CompanyProgram, type: :model do
  describe 'associations' do
    let(:response) { described_class.new }
    context 'company' do
      relation = described_class.reflect_on_association(:company)
      it { expect(relation.macro).to eq :belongs_to }
    end

    context 'program' do
      relation = described_class.reflect_on_association(:program)
      it { expect(relation.macro).to eq :belongs_to }
    end

    context 'coach' do
      relation = described_class.reflect_on_association(:coach)
      it { expect(relation.macro).to eq :belongs_to }
    end

    context 'employee_company_programs' do
      relation = described_class.reflect_on_association(:employee_company_programs)
      it { expect(relation.macro).to eq :has_many }
    end

    context 'employee_company_programs' do
      relation = described_class.reflect_on_association(:employees)
      it { expect(relation.macro).to eq :has_many }
    end
  end

  describe 'scopes' do
    describe '.enabled_programs' do
      it 'returns company programs with enabled programs' do
        enabled_program = create(:program, enabled: true)
        disabled_program = create(:program, enabled: false)
        company_program_enabled = create(:company_program, program: enabled_program)
        company_program_disabled = create(:company_program, program: disabled_program)

        expect(CompanyProgram.enabled_programs).to include(company_program_enabled)
        expect(CompanyProgram.enabled_programs).not_to include(company_program_disabled)
      end
    end
  end

  describe 'validations' do
    let(:valid_company_program) { build(:company_program) }
    let(:existing_company_program) { create(:company_program) }

    it 'validates uniqueness of coach' do
      valid_company_program.coach_id = existing_company_program.coach_id
      valid_company_program.company_id = existing_company_program.company_id
      valid_company_program.program_id = existing_company_program.program_id
      expect(valid_company_program).not_to be_valid
    end
  end

  describe 'default_scope' do
    it 'orders by created_at in descending order' do
      first_company_program = create(:company_program)
      second_company_program = create(:company_program)

      expect(CompanyProgram.all).to eq([second_company_program, first_company_program])
    end
  end

  describe 'pg_search_scope' do
    it 'searches by program name' do
      program = create(:program, name: 'Test Program')
      company_program = create(:company_program, program: program)

      expect(CompanyProgram.search_by_program_name('Test')).to include(company_program)
      expect(CompanyProgram.search_by_program_name('Invalid')).not_to include(company_program)
    end
  end
end
