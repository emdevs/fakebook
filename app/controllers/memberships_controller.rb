class MembershipsController < ApplicationController
    def create
        @membership = current_user.memberships.build(membership_params)

        if @membership.save
            flash[:alert] = "Successfully joined club!"
            redirect_to @membership.club
        else
            redirect_to clubs_path
        end
    end

    def update
        #update to block or unblock user
    end

    def destroy
        @membership = Membership.find(params[:id])
        @membership.destroy
        flash[:alert] = "Left club."
        redirect_to clubs_path
    end

    private

    def membership_params
        params.permit(:club_id)
    end
end
