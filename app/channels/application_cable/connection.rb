# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#     identified_by :current_user

#     def connect
#       self.current_user = find_verified_user
#     end

#     private
#       def find_verified_user
#         if verified_user = User.find_by(id: cookies.encrypted[:user_id])
#           verified_user
#         else
#           reject_unauthorized_connection
#         end
#       end
#   end
# end

#broadcast is broadcasting, but it seems like user is not connected to the channel/connection whatever in the
#first place.

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      if verified_user = env['warden'].user
        verified_user
      else
        reject_unauthorized_connection
      end
    end
  end
end