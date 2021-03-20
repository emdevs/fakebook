class ProfilesController < ApplicationController
    def show
        @user = User.find(params[:user_id])
        @profile = Profile.find_by(user_id: @user.id)
    end

    def edit
        @profile = current_user.profile
    end

    def update
        @profile = current_user.profile
        
        if @profile.update(profile_params)
            flash[:alert] = "Profile successfully saved!"
            redirect_to user_profile_path(current_user)
        else
            render :edit
        end
    end

    private

    def profile_params
        params.require(:profile).permit(:bio, :profile_pic)
    end
end


