class ChatroomsController < ApplicationController
    #what should go in here?
    def show
        @club = Club.find(params[:club_id])
        @chatroom = Chatroom.find_by(club: @club)

        @messages = @chatroom.messages.includes(:user)
        @message = @chatroom.messages.new
    end


    #need to check if user is member of club here
end
