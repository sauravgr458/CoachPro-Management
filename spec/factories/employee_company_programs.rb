# frozen_string_literal: true

FactoryBot.define do
  factory :employee_company_program do
    association :employee
    association :company_program
  end
end
