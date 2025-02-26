# frozen_string_literal: true

# Create Coaches
5.times do
  coach = Coach.create!(
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone_number: Faker::PhoneNumber.phone_number,
    password: 'password',
    password_confirmation: 'password'
  )

  puts "Coach created with email: #{coach.email}"
end

puts ''

# Create Companies
5.times do
  company = Company.create!(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    phone_number: Faker::PhoneNumber.phone_number
  )

  puts "Company created with name: #{company.name}"
end

puts ''

# Create Programs
5.times do
  program = Program.create!(
    name: Faker::Educator.course_name,
    description: Faker::Lorem.paragraph,
    enabled: Faker::Boolean.boolean
  )

  puts "Program created with name: #{program.name}"
end

puts ''

# Create CompanyPrograms
Company.all.each do |company|
  Program.all.each do |program|
    CompanyProgram.create!(
      company: company,
      program: program,
      coach: Coach.all.sample
    )

    puts "CompanyProgram created for #{company.name} - #{program.name}"
  end
end

puts ''

# Create Landing Pages
Company.all.each do |company|
  company.create_landing_page(
    heading: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )

  puts "Landing Page created for #{company.name}"
end
