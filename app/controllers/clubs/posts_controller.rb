class Clubs::PostsController < PostsController
    #this will inherit like method on post
    def index
        @posts = Post.where(postable_type: "Club", postable_id: params[:club_id]).order('created_at DESC')
    end
end