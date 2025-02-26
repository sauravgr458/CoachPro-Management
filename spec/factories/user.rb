# frozen_string_literal: true

# spec/factories/user.rb

FactoryBot.define do
  factory :user do
    email { 'lizabeth@schowalter.example' }
    first_name { 'Stanton' }
    last_name { 'Thompson' }
    phone_number { '102-696-3309 x921' }
    provider { 'email' }
    password { 'password123' }
    password_confirmation { 'password123' }

    # association :company
    association :invitation
  end
end
