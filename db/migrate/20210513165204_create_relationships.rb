# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :character_from, foreign_key: false
      t.references :character_to, foreign_key: false

      t.timestamps
    end
    add_foreign_key :relationships, :characters, column: :character_from_id
    add_foreign_key :relationships, :characters, column: :character_to_id
  end
end
