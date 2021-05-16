class ChatroomsController < ApplicationController

    #maybe nest this under clubs controller?
    before_action :check_member 
    before_action :check_blocked

    def show
        @club = Club.find(params[:club_id])
        @chatroom = Chatroom.find_by(club: @club)

        @messages = @chatroom.messages.includes(:user).order("created_at ASC")
        @message = @chatroom.messages.new
    end
    #need to check if user is member of club here/is blocked

    protected

    def check_blocked
        @club = Club.find(params[:club_id])

        @membership = Membership.find_by(member_id: current_user.id, club_id: params[:club_id])
        if (@membership.blocked == true)
            #add flash[:error] to club show page later
            flash[:alert] = "You are blocked from this club."
            redirect_to @club
        end
    end

    def check_member
        @club = Club.find(params[:club_id])
        @membership = Membership.find_by(member_id: current_user.id, club_id: params[:club_id])

        if @membership.nil?
            flash[:alert] = "You must be a member of this club"
            redirect_to @club
        end
    end
end
