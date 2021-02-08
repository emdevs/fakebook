class ProfilesController < ApplicationController
    def show
    
    end

    def edit
        @user = User.find(id: current_user.id)
    end
end
