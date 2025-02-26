# frozen_string_literal: true

class LandingPage < ApplicationRecord
  belongs_to :company

  validates :heading, :description, presence: true

  validates :heading, uniqueness: {
    scope: [:company_id]
  }
end
