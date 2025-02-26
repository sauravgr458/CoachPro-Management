# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      protect_from_forgery unless: -> { request.format.json? }

      private

      def apply_company_programs_search
        return unless params[:search]

        @company_programs = @company_programs.search_by_program_name(params[:search])
      end

      def set_company_programs_meta_data
        @metadata = {
          total_count: @company_programs.count,
          current_page: params[:page] || 1
        }
      end

      def apply_company_programs_pagination
        @company_programs = @company_programs.paginate(page: params[:page] || 1, per_page: params[:per_page] || 10)
      end
    end
  end
end
