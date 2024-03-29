class Like < ApplicationRecord
  #given post_id, user_id is unique
  #make sure that user cannot like own post (in model)
  validates :user_id, uniqueness: {scope: [:likeable_id, :likeable_type]}
  # validates :user_id, uniqueness: {scope: :likeable_id}

  belongs_to :user
  belongs_to :likeable, :polymorphic => true

  #like needs to belong to both user_id and imageable_id
  #belongs_to :likeable(post/comment), polymorphic => true
end
