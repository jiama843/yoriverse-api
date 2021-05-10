# frozen_string_literal: true

class AddFeaturesToCharacterTable < ActiveRecord::Migration[5.1]
  def change
    add_column :characters, :first_name, :string
    add_column :characters, :last_name, :string
    add_column :characters, :age, :integer
    add_column :characters, :height, :decimal
    add_column :characters, :weight, :decimal
    add_column :characters, :date_of_birth, :datetime
    # add_column :characters, :location_of_birth, :string # This should probably be an association to locations table
    add_column :characters, :description, :string

    remove_column :characters, :relationships # going to become preloaded association
  end
end
