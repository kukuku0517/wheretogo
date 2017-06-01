class Like < ActiveRecord::Base
    belongs_to :room
    has_many :userlikes
    has_many :users, :through => :userlikes
end
