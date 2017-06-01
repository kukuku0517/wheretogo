class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :room_id
      t.string :place
      t.float :lat
      t.float :lng
      t.string :placeUrl
      t.integer :count,:default => 1
      

      t.timestamps null: false
    end
  end
end
