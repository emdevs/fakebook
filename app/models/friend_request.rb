class FriendRequest < ApplicationRecord
    #need to add validation to make sure combination of requester and reciever is unique

    belongs_to :requester, class_name: "User"
    belongs_to :reciever, class_name: "User"
end
