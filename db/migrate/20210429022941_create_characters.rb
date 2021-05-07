class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :appearance
      t.string :traits
      t.string :relationships

      t.timestamps
    end
  end
end
