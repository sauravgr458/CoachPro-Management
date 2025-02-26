# frozen_string_literal: true

module Api
  module V1
    module Users
      class InvitationsController < Devise::InvitationsController
        # PUT /resource/invitation
        def update
          user = User.accept_invitation!(accept_invitation_params)
          if user.errors.empty?
            user.mark_invitation_as_accepted
            render json: { success: true, message: 'Invitation accepted' }, status: :accepted
          else
            render json: { success: false, errors: user.errors.full_messages.to_sentence },
                   status: :unprocessable_entity
          end
        end

        private

        def accept_invitation_params
          params.require(:user).permit(:password, :password_confirmation, :invitation_token)
        end
      end
    end
  end
end
