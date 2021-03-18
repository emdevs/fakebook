class Profile < ApplicationRecord
    #attach profile pic
    belongs_to :user
end
