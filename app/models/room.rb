class Room < ActiveRecord::Base
     belongs_to :user
     has_many :places
     has_many :likes
     has_many :userlikes
end
