class ChatroomChannel < ApplicationCable::Channel
    def subscribed
        club = Club.find(params[:club_id])
        chatroom = Chatroom.find_by(club: club)
        stream_for chatroom

        # stream_from "chatroom_#{params[:club_id]}"??
    end
end