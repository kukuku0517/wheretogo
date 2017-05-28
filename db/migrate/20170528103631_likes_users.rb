class LikesUsers < ActiveRecord::Migration
  def change
     create_table :likes_users, id: false do |t|
      t.belongs_to :like, index: true
      t.belongs_to :user, index: true
    end
  end
end
