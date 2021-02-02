class FriendRequest < ApplicationRecord
    belongs_to :requester, class_name: "User"
    belongs_to :reciever, class_name: "User"
end
