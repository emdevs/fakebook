class UserValidator < ActiveModel::Validator
    def validate(record)
        #min age = 13, max age = 120
        if record.birth_date? 
            if (record.birth_date + 13.years >= Date.today)
                record.errors.add(:birth_date, '(you should be at least 13 years old)')
            elsif (record.birth_date + 120.years < Date.today)
                record.errors.add(:birth_date, '(please choose a valid age)')
            end
        end
    end
end