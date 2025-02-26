# frozen_string_literal: true

json.id @landing_page.id
json.heading @landing_page.heading
json.company_id @landing_page.company_id
json.logo @landing_page.company.logo_url
json.description @landing_page.description
json.cover_photo @landing_page.company.cover_photo_url
