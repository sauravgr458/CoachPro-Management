# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user!
      before_action :set_company_programs, only: [:dashboard]
      before_action :apply_company_programs_search, only: [:dashboard]
      before_action :set_company_programs_meta_data, only: [:dashboard]
      before_action :apply_company_programs_pagination, only: [:dashboard]

      def dashboard; end

      private

      def set_company_programs
        @company_programs = current_user.company_programs
                                        .includes(:company, :program)
      end
    end
  end
end
