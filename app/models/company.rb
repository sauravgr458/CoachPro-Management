# frozen_string_literal: true

class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :logo
  has_one_attached :cover_photo
  has_one :landing_page, dependent: :destroy

  has_many :company_programs, dependent: :destroy
  has_many :programs, through: :company_programs

  has_many :employees

  validates :name, :email, :address, :city, :state, :country, :phone_number, presence: true
  validates :name, uniqueness: true

  def logo_url
    if logo.attached?
      Rails.application.routes.url_helpers.rails_blob_url(logo, only_path: true)
    else
      ActionController::Base.helpers.asset_url('default-company-logo.png')
    end
  end

  def cover_photo_url
    if cover_photo.attached?
      Rails.application.routes.url_helpers.rails_blob_url(cover_photo, only_path: true)
    else
      ActionController::Base.helpers.asset_url('default-cover-image.png')
    end
  end
end
