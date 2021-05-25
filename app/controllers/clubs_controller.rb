class ClubsController < ApplicationController
    #need some kinda validation for show, only let members/owner view the club
    before_action :require_owner, only: [:edit, :update, :destroy]

    def index
        @clubs = Club.all
    end

    def show
        @club = Club.find(params[:id])
    end

    def new
        @club = Club.new
    end

    def create
        #if new club is created, auto create membership for owner?
        @club = current_user.owned_clubs.build(club_params)

        if @club.save
            flash[:alert] = "Club successfully created."
            redirect_to @club
        else
            render :new
        end
    end

    def edit
        @club = Club.find(params[:id])
    end

    def update
        @club = Club.find(params[:id])

        if @club.update(club_params)
            flash[:alert] = "Club succesfully saved."
            redirect_to @club
        else
            render :edit
        end
    end

    def destroy
        @club = Club.find(params[:id])
        # @post.image.purge
        @club.destroy
        flash[:alert] = "Club succesfully destroyed."

        redirect_to clubs_path
    end

    private

    def club_params
        params.require(:club).permit(:owner_id, :name, :description, :capacity, :image)
    end

    def require_owner
        #might be redundant
        @club = Club.find(params[:id])
        unless (current_user.id == @club.owner_id)
            flash[:alert] = "You do not have permission to perform this action."
            redirect_to @club
        end
    end

end
