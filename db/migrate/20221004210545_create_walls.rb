class CreateWalls < ActiveRecord::Migration[6.1]
  def change
    create_table :walls do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
