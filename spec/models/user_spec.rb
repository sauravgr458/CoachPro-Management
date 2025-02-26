# frozen_string_literal: true

# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_length_of(:phone_number).is_at_least(10) }
  end

  describe '#name' do
    let(:invitation) { create(:invitation) }
    let(:user) do
      create(:user, first_name: 'John', last_name: 'Doe', email: 'john@example.com', invitation_id: invitation.id)
    end

    it 'returns the full name with email' do
      expect(user.name).to eq('John Doe (john@example.com)')
    end
  end

  describe '#mark_invitation_as_accepted' do
    let(:invitation) { create(:invitation) }
    let(:user) { create(:user, invitation_id: invitation.id) }

    context 'when user has an invitation' do
      xit 'marks the invitation as accepted' do
        allow(user).to receive(:invitation).and_return(double(update: true))
        user.mark_invitation_as_accepted

        expect(user.invitation).to have_received(:update).with(accepted: true)
      end
    end
    context 'when user has no invitation' do
      xit 'does not raise error' do
        expect { user.mark_invitation_as_accepted }.not_to raise_error
      end
    end
  end
end
