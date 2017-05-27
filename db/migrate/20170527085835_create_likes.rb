class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :room_id
      t.integer :user_id
      t.string :place

      t.timestamps null: false
    end
  end
end