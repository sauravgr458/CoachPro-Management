# frozen_string_literal: true

# spec/models/program_spec.rb

require 'rails_helper'

RSpec.describe Program, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      program = Program.new(name: 'Test Program', description: 'Test Description')
      expect(program).to be_valid
    end

    it 'is not valid without a name' do
      program = Program.new(description: 'Test Description')
      expect(program).not_to be_valid
    end

    it 'is not valid without a description' do
      program = Program.new(name: 'Test Program')
      expect(program).not_to be_valid
    end

    it 'is not valid with a duplicate name' do
      Program.create(name: 'Test Program', description: 'Test Description')
      program = Program.new(name: 'Test Program', description: 'Another Description')
      expect(program).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many company_programs' do
      association = described_class.reflect_on_association(:company_programs)
      expect(association.macro).to eq :has_many
    end

    it 'has many companies through company_programs' do
      association = described_class.reflect_on_association(:companies)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :company_programs
    end
  end

  describe 'cover_image_url' do
    it 'returns default cover image URL if cover image is not attached' do
      program = Program.new
      expect(program.cover_image_url).to eq ActionController::Base.helpers.asset_url('default-cover-image.png')
    end

    xit 'returns the URL of the attached cover image' do
      program = Program.new
      program.cover_image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'default-cover-image.png')),
                                 filename: 'default-cover-image.png', content_type: 'image/jpeg')
      expect(program.cover_image_url).to include 'default-cover-image.png'
    end
  end

  describe 'gallery_image_urls' do
    it 'returns an empty array if no gallery images are attached' do
      program = Program.new
      expect(program.gallery_image_urls).to eq []
    end

    xit 'returns an array of URLs for attached gallery images' do
      program = Program.new
      program.gallery_images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'default-cover-image.png')),
                                    filename: 'default-cover-image.png', content_type: 'image/jpeg')
      program.gallery_images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'default-company-logo.png')),
                                    filename: 'default-company-logo.png', content_type: 'image/jpeg')
      expect(program.gallery_image_urls.length).to eq 2
      expect(program.gallery_image_urls).to all(include('default-company-logo'))
    end
  end
end
