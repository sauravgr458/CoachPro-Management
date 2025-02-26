# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    email { "employee_#{SecureRandom.hex}@gmail.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
    password { 'password' }
    password_confirmation { 'password' }
    type { 'Employee' }
    invitation_id { nil }
  end
end
