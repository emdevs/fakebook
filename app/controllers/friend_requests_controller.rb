class FriendRequestsController < ApplicationController
    #all possible people you can send requests to 
    def index
        @new_users = default_users(10)
        
        @pending_users = current_user.pending_invitees
        @invites_from = current_user.invites_from
    end

    def search
        #current user will not be returned as a result
        query = params[:query]
        
        #loads 10 users that aren't friends with current_user by default. 
        @users = default_users(10)

        if query != "" 
            @users = User.find_by_sql("SELECT * FROM users WHERE UPPER(name) LIKE UPPER('%#{query}%') AND id <> #{current_user.id}")
        end

        respond_to do |format|
            format.js {render layout: false}
        end
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

    #returns 10 default users (users you can send request to)
    def default_users(limit)
        return current_user.can_send_request.limit(limit)
    end

    def friend_request_params
        params.permit(:reciever_id)
    end
end
