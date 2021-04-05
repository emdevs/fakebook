class Clubs::PostsController < PostsController
    def index
        @posts = Post.where(postable_type: "Club").order('created_at DESC')
    end
end