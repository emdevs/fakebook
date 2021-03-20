class Profile < ApplicationRecord
    #attach profile pic
    has_one_attached :profile_pic, dependent: :destory
    belongs_to :user
end
