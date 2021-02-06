class NotificationsController < ApplicationController
    def index
        @users = current_user.invites_from
        @requests = current_user.pending_friend_requests
    end
end
