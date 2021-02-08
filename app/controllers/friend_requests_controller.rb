class FriendRequestsController < ApplicationController
    #all possible people you can send requests to 
    def index
        @new_users = current_user.can_send_request
        @pending_users = current_user.pending_invitees

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
        @request.save

        redirect_to notifications_path
    end

    def destroy
        @request = FriendRequest.find(params[:id])

        @request.destroy
        
        flash[:alert] = "Friend request cancelled."
        redirect_to friend_requests_path 
    end

    private

    def friend_request_params
        params.permit(:reciever_id)
    end
end
