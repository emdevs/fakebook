class UsersController < ApplicationController
    def index
        @users = Users.all

        @friend_request = FriendRequest.new
    end
end
