class ChatroomsController < ApplicationController
    def show
        @club = Club.find(params[:club_id])
        @chatroom = Chatroom.find_by(club: @club)

        @messages = @chatroom.messages.includes(:user).order("created_at ASC")
        @message = @chatroom.messages.new
    end
    #need to check if user is member of club here/is blocked
end
