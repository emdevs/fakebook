class Profile < ApplicationRecord
    #add validations for birthday 
    belongs_to :user
end
