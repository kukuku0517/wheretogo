class CreateUserlikes < ActiveRecord::Migration
  def change
    create_table :userlikes do |t|
      t.integer :room_id
      t.integer :user_id
      t.integer :like_id

      t.timestamps null: false
    end
  end
end
