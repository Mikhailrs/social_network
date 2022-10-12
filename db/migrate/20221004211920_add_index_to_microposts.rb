class AddIndexToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_index :microposts, [:wall_id, :created_at]
  end
end
