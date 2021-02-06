class Like < ApplicationRecord
  #given post_id, user_id is unique
  validates :user_id, uniqueness: {scope: :post_id}

  belongs_to :user
  belongs_to :post
end
