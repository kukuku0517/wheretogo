class Room < ActiveRecord::Base
     belongs_to :user
     has_many :places
     has_many :likes
end
