# frozen_string_literal: true

module Api
  module V1
    class LandingPagesController < Api::V1::ApiController
      before_action :set_company

      def show
        @landing_page = @company.landing_page
      end

      private

      def set_company
        @company = Company.find_by(slug: params[:company_slug])

        return if @company.present?

        render json: { message: "#{params[:company_slug]} is not found" }, status: :not_found
      end
    end
  end
end
