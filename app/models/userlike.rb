class Userlike < ActiveRecord::Base
    belongs_to :user
    belongs_to :like
end
