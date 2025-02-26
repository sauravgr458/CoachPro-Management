# frozen_string_literal: true

FactoryBot.define do
  factory :landing_page do
    heading { Faker::Quote.robin }
    description { Faker::Lorem.paragraph }
    association :company
  end
end
