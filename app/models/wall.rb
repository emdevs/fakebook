class Wall < ApplicationRecord
    validate :check_record, on: :create
    has_many :posts, as: :postable
    
    def check_record
        if Wall.all.count > 0
            errors.add(:base, :invalid, "There can only be one wall model instance")
        end
    end
end
