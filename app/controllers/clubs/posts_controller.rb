class Clubs::PostsController < PostsController
    #make sure later that check member ALWAYS runs before check_blocked, or it will error why does prepend_before_action result error?
    before_action :check_member 
    before_action :check_blocked

    def index
        #maybe all posts, from UNBLOCEKD USERS only?
        @posts = Post.where(postable_type: "Club", postable_id: params[:club_id]).order('created_at DESC')
    end

    private

    def check_blocked
        @membership = Membership.find_by(member_id: current_user.id, club_id: @postable.id)
        if (@membership.blocked == true)
            #add flash[:error] to club show page later
            flash[:alert] = "You are blocked from this club."
            redirect_to club_path(@membership.club_id)
        end
    end

    def check_member
        @membership = Membership.find_by(member_id: current_user.id, club_id: @postable.id)
        if @membership.nil?
            flash[:alert] = "You must be a member of this club"
            redirect_to @postable
        end
    end
end