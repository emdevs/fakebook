class Clubs::PostsController < PostsController
    #this will inherit like method on post
    def index
        @posts = Post.where(postable_type: "Club").order('created_at DESC')
    end
end