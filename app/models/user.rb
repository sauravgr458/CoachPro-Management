# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  include DeviseTokenAuth::Concerns::User

  validates :email, :first_name, :last_name, :phone_number, presence: true
  validates :phone_number, length: { minimum: 10 }

  def name
    "#{first_name} #{last_name} (#{email})"
  end

  def mark_invitation_as_accepted
    invitation.update(accepted: true)
  end
end
