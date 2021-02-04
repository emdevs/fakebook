class FriendRequestsController < ApplicationController
    # def new
    #     @request = curent_user.sent_friend_requests.build
    # end

    def create
        @request = current_user.sent_friend_requests.build(friend_request_params)

        if @request.save
            redirect_to root_path
        else
            redirect_to user_profile(current_user.id)  
        end      
    end

    def delete
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:reciever_id)
    end
end
