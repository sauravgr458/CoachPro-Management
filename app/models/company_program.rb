# frozen_string_literal: true

class CompanyProgram < ApplicationRecord
  include PgSearch::Model

  belongs_to :company
  belongs_to :program
  belongs_to :coach

  has_many :employee_company_programs, dependent: :destroy
  has_many :employees, through: :employee_company_programs

  default_scope { order(created_at: :desc) }
  scope :enabled_programs, -> { joins(:program).where(program: { enabled: true }) }

  pg_search_scope :search_by_program_name, associated_against: {
    program: :name
  }

  validates :coach_id, uniqueness: {
    scope: %i[company_id program_id]
  }
end
