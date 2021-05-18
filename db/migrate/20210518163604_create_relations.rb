class CreateRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :relations do |t|
      t.references :character_from, foreign_key: true
      t.references :character_to, foreign_key: true

      t.timestamps
    end
  end
end
