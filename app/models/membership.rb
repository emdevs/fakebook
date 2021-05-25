class Membership < ApplicationRecord
    validates :member_id, uniqueness: {scope: :club_id}
    validate :club_not_full, on: :create

    belongs_to :club
    belongs_to :member, class_name: "User"

    private

    #make sure member capacity of club (unblocked users) currently isnt full before creating membership
    def club_not_full
        @club = Club.find(self.club_id)
        unless (@club.member_count < @club.capacity)
            errors.add(:member_id, "Club is full")
        end
    end
end
