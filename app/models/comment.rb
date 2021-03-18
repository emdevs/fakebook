class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :post
    belongs_to :user

    has_many :likes, :as => :likeable, dependent: :destroy

    def date
        self.created_at.strftime("%d-%m-%Y %H:%M")
    end

    def liked?(user)
        self.likes.find{|like| like.user_id == user.id}
    end
end
