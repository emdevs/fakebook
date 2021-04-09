class MembershipsController < ApplicationController
    before_action :require_owner, only: [:update]
    #shouldnt allow blocked users to "leave" club (which would destroy the membership, and if they rejoined, allowed them back in)
    before_action :require_unblocked_user, only: [:destroy]

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
        unless (@membership.member_id == @club.owner_id)
            block_status = (@membership.blocked == false)? true : false
            @membership.update(blocked: block_status)
        else
            flash[:alert] = "You can't block yourself, duh!"
        end
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
        #as of now, only owner can unblock and block users.
        @membership = Membership.find(params[:id])
        @club = Club.find(@membership.club_id)
        unless (current_user.id == @club.owner_id)
            flash[:alert] = "You do not have the permission to block users"
            redirect_to @club
        end
    end

    def require_unblocked_user
        @membership = Membership.find(params[:id])
        unless (@membership.blocked == false)
            redirect_to clubs_path
        end
    end
end
