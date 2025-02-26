# frozen_string_literal: true

module RailsAdmin
  module Config
    module Actions
      class Logout < RailsAdmin::Config::Actions::Base
        # This ensures the action is available only for authenticated users
        register_instance_option :visible? do
          authorized?
        end

        # Controller logic for the logout action
        register_instance_option :controller do
          proc do
            # Clear the HTTP basic authentication credentials
            request.env['HTTP_AUTHORIZATION'] = nil
            # Redirect to the root path or any other path you prefer
            redirect_to main_app.root_path, notice: 'Logged out successfully'
          end
        end
      end
    end
  end
end
