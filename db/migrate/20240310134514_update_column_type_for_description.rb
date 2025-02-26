# frozen_string_literal: true

class UpdateColumnTypeForDescription < ActiveRecord::Migration[6.1]
  def change
    change_column(:landing_pages, :description, :text)
    change_column(:programs, :description, :text)
  end
end
