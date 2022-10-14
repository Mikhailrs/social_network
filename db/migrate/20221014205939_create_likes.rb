class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :micropost, null: false, foreign_key: true
      t.index %i[user_id micropost_id], unique: true

      t.timestamps
    end

    add_column :microposts, :likes_count, :integer, null: false, default: 0
  end
end
