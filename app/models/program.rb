# frozen_string_literal: true

class Program < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :cover_image
  has_many_attached :gallery_images

  has_many :company_programs, dependent: :destroy
  has_many :companies, through: :company_programs

  validates :name, :description, presence: true
  validates :name, uniqueness: true

  def cover_image_url
    if cover_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(cover_image, only_path: true)
    else
      ActionController::Base.helpers.asset_url('default-cover-image.png')
    end
  end

  def gallery_image_urls
    urls = []
    if gallery_images.attached?
      gallery_images.each do |image|
        urls << Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true)
      end
    end
    urls
  end
end
