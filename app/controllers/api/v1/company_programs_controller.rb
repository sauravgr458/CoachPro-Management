# frozen_string_literal: true

module Api
  module V1
    class CompanyProgramsController < Api::V1::ApiController
      before_action :set_company, only: %i[index show]
      before_action :set_company_programs, only: %i[index show]
      before_action :authenticate_user!, except: [:index]
      before_action :apply_company_programs_search, only: [:index]
      before_action :set_company_programs_meta_data, only: [:index]
      before_action :apply_company_programs_pagination, only: [:index]

      def index; end

      def show
        @company_program = @company_programs.find_by(id: params[:id])

        if @company_program.present?
          current_user.join_program(@company_program) if current_user.type == 'Employee'
        else
          render json: { message: "Company Program with ID:#{params[:id]} is not found." }, status: :not_found
        end
      end

      private

      def set_company
        @company = Company.find_by(id: params[:company_id])

        return if @company.present?

        render json: { message: "Company with ID:#{params[:company_id]} is not found." }, status: :not_found
      end

      def set_company_programs
        @company_programs = @company.company_programs
                                    .enabled_programs
                                    .includes(:company, :program)
      end
    end
  end
end
