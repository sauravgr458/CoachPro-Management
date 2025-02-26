# frozen_string_literal: true

# spec/models/landing_page_spec.rb

require 'rails_helper'

RSpec.describe LandingPage, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:heading) }
    it { should validate_presence_of(:description) }

    it 'validates uniqueness of heading scoped to company' do
      company = create(:company)
      existing_landing_page = create(:landing_page, company: company)
      new_landing_page = build(:landing_page, heading: existing_landing_page.heading, company: company)
      new_landing_page.valid?
      expect(new_landing_page.errors[:heading]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it { should belong_to(:company) }
  end
end
