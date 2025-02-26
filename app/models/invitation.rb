# frozen_string_literal: true

class Invitation < ApplicationRecord
  has_one :coach, dependent: :destroy

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :phone_number, length: { minimum: 10 }
  validates :email, uniqueness: true

  after_create :invite_coach
  validate :unique_coach, on: :create

  def invite_coach
    Coach.invite!(email: email, first_name: first_name, last_name: last_name, phone_number: phone_number,
                  invitation_id: id)
  end

  def unique_coach
    errors.add(:email, 'already present for a coach.') if Coach.find_by(email: email)
  end
end
