# frozen_string_literal: true

class Coach < User
  has_many :company_programs, dependent: :destroy

  belongs_to :invitation, optional: true
end
