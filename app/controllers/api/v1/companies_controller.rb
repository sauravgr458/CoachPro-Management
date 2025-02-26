# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < Api::V1::ApiController
      def index
        @companies = Company.all
      end
    end
  end
end
