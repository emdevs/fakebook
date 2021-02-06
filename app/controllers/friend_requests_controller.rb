class FriendRequestsController < ApplicationController
    # def new
    #     @request = curent_user.sent_friend_requests.build
    # end

    def create
        @request = current_user.sent_friend_requests.build(friend_request_params)

        if @request.save
            #friend equest sent!
            redirect_to friend_requests_path
        else
            #error message?
            redirect_to friend_requests_path
        end      
    end

    def destroy
        @user = User.find(params[:id])

        @user.destroy
        #flash msg?
        redirect_to friend_requests_path 
    end

    #all possible people you can send requests to 
    def index
        @new_users = current_user.can_send_request
        @pending_users = current_user.pending_invitees


        @friend_request = current_user.sent_friend_requests.build
        #people to send requests to
        #and people you already sent requests to (but are waiting for answer? greyed out send button?)
    end

    private

    def friend_request_params
        params.require(:request).permit(:reciever_id)
    end
end
