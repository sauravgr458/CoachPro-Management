# frozen_string_literal: true

RailsAdmin.config do |config|
  config.asset_source = :webpacker

  config.main_app_name = ['Administration']

  config.excluded_models = %w[EmployeeCompanyProgram User]

  config.default_hidden_fields = {
    edit: %i[id created_at updated_at],
    show: %i[id updated_at created_at]
  }

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :admin
  # end

  # config.current_user_method(&:current_admin)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  # employee
  config.model 'Employee' do
    list do
      field :id
      field :email
      field :first_name
      field :last_name
      field :phone_number
    end

    edit do
      exclude_fields :created_at, :updated_at, :reset_password_sent_at, :remember_created_at
    end

    create do
      exclude_fields :created_at, :updated_at, :reset_password_sent_at, :remember_created_at,
                     :employee_company_programs, :company_programs
    end
  end

  # company
  config.model 'Company' do
    list do
      field :id
      field :email
      field :address
      field :city
      field :state
      field :country
      field :phone_number
    end

    edit do
      exclude_fields :employee_company_programs, :company_programs, :programs, :slug, :landing_page
    end

    create do
      exclude_fields :employee_company_programs, :company_programs, :programs, :slug, :landing_page
    end
  end

  # Program
  config.model 'Program' do
    list do
      field :id
      field :name
      field :description
      field :enabled
    end

    edit do
      exclude_fields :companies, :company_programs, :slug
    end

    create do
      exclude_fields :companies, :company_programs, :slug
    end
  end

  # Invitation
  config.model 'Invitation' do
    edit do
      exclude_fields :accepted, :coach
    end

    create do
      exclude_fields :accepted, :coach
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.authorize_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      username == Rails.application.secrets.user && password == Rails.application.secrets.password
    end
  end
end
