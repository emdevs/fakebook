class Wall < ApplicationRecord
    #homepage wall
    has_many :posts, as: :postable
end
