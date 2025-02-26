# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { described_class.new }
  let(:valid_company) { build(:company) }
  let(:existing_company) { create(:company) }

  describe 'associations' do
    context 'company_programs' do
      relation = described_class.reflect_on_association(:company_programs)
      it { expect(relation.macro).to eq :has_many }
    end

    context 'landing_page' do
      relation = described_class.reflect_on_association(:landing_page)
      it { expect(relation.macro).to eq :has_one }
      it { expect(relation.options[:dependent]).to eq :destroy }
    end

    context 'programs' do
      relation = described_class.reflect_on_association(:programs)
      it { expect(relation.macro).to eq :has_many }
      it { expect(relation.options[:through]).to eq :company_programs }
    end

    context 'employees' do
      relation = described_class.reflect_on_association(:employees)
      it { expect(relation.macro).to eq :has_many }
    end
  end

  describe 'validations' do
    context 'with invalid details' do
      it 'validates presence of name' do
        valid_company.name = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of email' do
        valid_company.email = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of address' do
        valid_company.address = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of city' do
        valid_company.city = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of state' do
        valid_company.state = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of country' do
        valid_company.country = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates presence of phone_number' do
        valid_company.phone_number = nil
        expect(valid_company).not_to be_valid
      end

      it 'validates uniqueness of name' do
        existing_company # Ensure the existing company is created
        valid_company.name = existing_company.name
        expect(valid_company).not_to be_valid
      end
    end

    context 'with valid details' do
      it 'should be valid' do
        expect(existing_company).to be_valid
      end
    end
  end

  describe '#logo_url' do
    context 'when logo is attached' do
      it 'returns the URL of the attached logo' do
        company = create(:company)
        logo_url = company.logo_url

        expect(logo_url).to include('default-company-logo.png')
      end
    end

    context 'when logo is not attached' do
      it 'returns the URL of the default company logo' do
        company = build(:company, logo: nil)
        logo_url = company.logo_url

        expect(logo_url).to include('default-company-logo.png')
      end
    end
  end

  describe '#cover_photo_url' do
    context 'when cover photo is attached' do
      it 'returns the URL of the attached cover photo' do
        company = create(:company)
        cover_photo_url = company.cover_photo_url

        expect(cover_photo_url).to include('default-cover-image.png')
      end
    end

    context 'when cover photo is not attached' do
      it 'returns the URL of the default cover photo' do
        company = build(:company, cover_photo: nil)
        cover_photo_url = company.cover_photo_url

        expect(cover_photo_url).to include('default-cover-image.png')
      end
    end
  end
end
