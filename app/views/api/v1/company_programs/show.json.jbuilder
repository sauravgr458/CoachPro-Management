# frozen_string_literal: true

json.id @company_program.id
json.name @company_program.program.name
json.description @company_program.program.description
json.cover_image @company_program.program.cover_image_url
json.gallery_images @company_program.program.gallery_image_urls
json.slug @company_program.program.slug
json.coach_name @company_program.coach.name
