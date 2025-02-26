# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Coach, type: :model do
  describe 'associations' do
    let(:response) { described_class.new }
    context 'company_programs' do
      relation = described_class.reflect_on_association(:company_programs)
      it { expect(relation.macro).to eq :has_many }
    end

    context 'invitation' do
      relation = described_class.reflect_on_association(:invitation)
      it { expect(relation.macro).to eq :belongs_to }
    end
  end

  describe 'validations' do
    let(:valid_coach) { build(:coach) }
    let(:existing_coach) { create(:coach) }

    context 'with invalid details' do
      it 'validates presence of email' do
        valid_coach.email = nil
        expect(valid_coach).not_to be_valid
      end

      it 'validates uniqueness of email' do
        valid_coach.email = existing_coach.email
        expect(valid_coach).not_to be_valid
      end

      it 'validates presence of first_name' do
        valid_coach.first_name = nil
        expect(valid_coach).not_to be_valid
      end

      it 'validates presence of last_name' do
        valid_coach.last_name = nil
        expect(valid_coach).not_to be_valid
      end

      it 'validates presence of phone_number' do
        valid_coach.phone_number = nil
        expect(valid_coach).not_to be_valid
      end

      it 'validates minimum length of phone_number' do
        valid_coach.phone_number = '12345'
        expect(valid_coach).not_to be_valid
      end

      it 'validates presence of password' do
        valid_coach.password = nil
        expect(valid_coach).not_to be_valid
      end

      it 'validates minimum length of password' do
        valid_coach.password = '12345'
        expect(valid_coach).not_to be_valid
      end

      it 'validates confirmation of password' do
        valid_coach.password_confirmation = 'abc'
        expect(valid_coach).not_to be_valid
      end
    end

    context 'with valid details' do
      it 'should be valid' do
        expect(existing_coach).to be_valid
      end
    end
  end

  describe 'methods' do
    let(:coach) { create(:coach) }

    describe '#name' do
      it 'returns the full name and email' do
        expect(coach.name).to eq("#{coach.first_name} #{coach.last_name} (#{coach.email})")
      end
    end

    describe '#mark_invitation_as_accepted' do
      let(:invitation) { create(:invitation) }

      it 'marks invitation as accepted' do
        invitation.coach.mark_invitation_as_accepted
        expect(invitation.reload.accepted).to be(true)
      end
    end
  end
end
