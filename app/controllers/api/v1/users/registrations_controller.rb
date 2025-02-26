# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        # Overrided method
        def sign_up_params
          params.permit(:email, :first_name, :last_name, :phone_number, :password, :password_confirmation, :type,
                        :company_id)
        end
      end
    end
  end
end
