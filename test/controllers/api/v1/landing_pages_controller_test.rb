# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class LandingPagesControllerTest < ActionDispatch::IntegrationTest
      test 'should get show' do
        get api_v1_landing_pages_show_url
        assert_response :success
      end
    end
  end
end
