class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :post
    belongs_to :user

    def date
        self.created_at.strftime("%d-%m-%Y %H:%M")
    end
end
