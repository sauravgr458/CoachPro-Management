# frozen_string_literal: true

json.array! @companies do |company|
  json.id company.id
  json.name company.name
  json.slug company.slug
end
