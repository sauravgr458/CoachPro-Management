# frozen_string_literal: true

FactoryBot.define do
  factory :invitation do
    email { "coach-i-#{SecureRandom.hex}@gmail.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
