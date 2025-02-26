# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < DeviseTokenAuth::SessionsController
        protected

        def render_create_success
          company_slug = @resource.type == 'Employee' ? @resource.company&.slug : nil
          render json: {
            data: resource_data(resource_json: @resource.token_validation_response)
              .merge(type: @resource.type.downcase, company_slug: company_slug)
          }
        end
      end
    end
  end
end
