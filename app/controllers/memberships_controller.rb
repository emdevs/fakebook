class MembershipsController < ApplicationController
    before_action :require_owner, only: [:update]

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
        #only unblock and block
        block_status = (@membership.blocked == false)? true : false
        @membership.update(blocked: block_status)
        redirect_to @club
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

    def require_owner
        @membership = Membership.find(params[:id])
        @club = Club.find(@membership.club_id)
        unless (current_user.id == @club.owner_id)
            flash[:alert] = "You do not have the permission to block users"
            redirect_to @club
        end
    end
end
