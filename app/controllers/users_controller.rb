class UsersController < ApplicationController
    def index
        @users = User.other_users(current_user.id)
        #those whom you havent sent a request, are waiting on a request for, or are already friends with

        @friend_request = current_user.sent_friend_requests.build
    end
end
