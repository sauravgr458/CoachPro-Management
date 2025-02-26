# frozen_string_literal: true

# spec/models/invitation_spec.rb

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_length_of(:phone_number).is_at_least(10) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'associations' do
    it { should have_one(:coach).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe 'after_create :invite_coach' do
      let(:invitation) { create(:invitation) }

      it 'invites a coach after creation' do
        expect { invitation }.to change { Coach.count }.by(1)
      end

      it 'creates a coach with correct attributes' do
        invitation # Trigger creation
        coach = Coach.last
        expect(coach.email).to eq(invitation.email)
        expect(coach.first_name).to eq(invitation.first_name)
        expect(coach.last_name).to eq(invitation.last_name)
        expect(coach.phone_number).to eq(invitation.phone_number)
        expect(coach.invitation_id).to eq(invitation.id)
      end
    end
  end

  describe 'custom validations' do
    describe '#unique_coach' do
      let(:invitation) { create(:invitation) }

      it 'adds an error if email is already present for a coach' do
        invitation # Trigger creation
        new_invitation = build(:invitation, email: invitation.email)
        new_invitation.valid?
        expect(new_invitation.errors[:email]).to include('already present for a coach.')
      end

      it 'does not add an error if email is not already present for a coach' do
        invitation # Trigger creation
        new_invitation = build(:invitation, email: 'new@example.com')
        new_invitation.valid?
        expect(new_invitation.errors[:email]).to_not include('already present for a coach.')
      end
    end
  end
end
