class Message < ApplicationRecord
  belongs_to :user
  belongs_to :messageable, polymorphic: true

  #make sure msg isnt blank
  validates :message, presence: true

  def datetime
    creation_date = self.created_at.strftime("%d-%m-%Y")

    if (creation_date == Date.today.strftime("%d-%m-%Y")) 
      creation_date = "Today at"
    elsif (creation_date == Date.yesterday.strftime("%d-%m-%Y"))
      creation_date = "Yesterday at"
    end
    
    return "#{creation_date} #{self.created_at.strftime("%H:%M")}"
  end
end
