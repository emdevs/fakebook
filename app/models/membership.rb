class Membership < ApplicationRecord
    #dont foregt
    #check that club is not full (self.club.member_count == self.club.capacity)
    validates :member_id, uniqueness: {scope: :club_id}

    belongs_to :club
    belongs_to :member, class_name: "User"
end
