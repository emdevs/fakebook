class UsersController < ApplicationController
    def index
        # @users = User.all
        
        #those whom you havent sent a request, are waiting on a request for, or are already friends with

        @friend_request = current_user.sent_friend_requests.build
    end

    def edit
        #need to estrict for only self
        @user = User.find(current_user.id)
    end

    def update
        @user = User.find(current_user.id)

        if @user.update(user_params)
            flash[:alert] = "Profile successfully updated!"
            redirect_to user_profile_path(current_user.id)
        else
            flash[:alert] = "There was an error in updating your profile."
            render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:profile_pic)
    end

end
