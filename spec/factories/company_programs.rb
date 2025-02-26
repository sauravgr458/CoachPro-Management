# frozen_string_literal: true

FactoryBot.define do
  factory :company_program do
    association :company
    association :program
    association :coach
  end
end
