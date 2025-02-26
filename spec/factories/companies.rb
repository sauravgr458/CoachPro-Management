# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Company #{n}" }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    phone_number { Faker::PhoneNumber.phone_number }

    after(:build) do |company|
      company.logo.attach(io: File.open('spec/fixtures/default-company-logo.png'),
                          filename: 'default-company-logo.png', content_type: 'image/png')
      company.cover_photo.attach(io: File.open('spec/fixtures/default-cover-image.png'),
                                 filename: 'default-cover-image.png', content_type: 'image/png')
    end
  end
end
