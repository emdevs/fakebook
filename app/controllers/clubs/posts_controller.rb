class Clubs::PostsController < PostsController
    before_action :check_blocked
    #this will inherit like method on post

    def index
        @posts = Post.where(postable_type: "Club", postable_id: params[:club_id]).order('created_at DESC')
    end


    private
    
    def check_blocked
        @membership = Membership.find_by(member_id: current_user.id, club_id: @postable.id)
        if (@membership.blocked == true)
            flash[:alert] = "You are blocked from this club."
            redirect_to club_path(@membership.club_id)
        end
    end
end