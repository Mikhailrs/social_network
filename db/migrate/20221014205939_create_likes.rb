class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false
      t.references :likeable, polymorphic: true, null: false
      t.index %i[user_id likeable_id likeable_type], unique: true

      t.timestamps
    end

    add_column :microposts, :likes_count, :integer, null: false, default: 0
  end
end
