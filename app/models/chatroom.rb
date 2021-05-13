class Chatroom < ApplicationRecord
  belongs_to :club
  has_many :messages, as: :messageable, dependent: :destroy
end
