class FriendRequestsController < ApplicationController
    #all possible people you can send requests to 
    def index
        @new_users = current_user.can_send_request
        
        @pending_users = current_user.pending_invitees
        @invites_from = current_user.invites_from
    end

    def create
        @request = current_user.sent_friend_requests.build(friend_request_params)

        if @request.save
            flash[:alert] = "Friend request sent!"
            redirect_to friend_requests_path
        else
            flash[:alert] = "There was an error, friend request not sent."
            redirect_to friend_requests_path
        end      
    end

    def update
        @request = FriendRequest.find(params[:id])
        @request.status = true

        #if friendship created, automatically create private chat. (user_1 user_2 order doesnt matter)
        if @request.save
            Chat.create(user_1_id: @request.requester.id, user_2_id: @request.reciever.id)
        end
            
        redirect_to friend_requests_path
    end

    def destroy
        #either cancel friend request, or unfriend
        @request = FriendRequest.find(params[:id])
        @request.destroy
        
        redirect_to friend_requests_path 
    end

    private

    def friend_request_params
        params.permit(:reciever_id)
    end
end
