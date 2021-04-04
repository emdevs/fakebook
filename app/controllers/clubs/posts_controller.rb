class Clubs::PostsController < PostsController
    def index
        @posts = Post.where(postable_type: "Club").order('created_at DESC')
    end

    def like
        @post = Post.find(params[:id])
        Like.create(user_id: current_user.id, likeable_id: @post.id, likeable_type: "Post")
        redirect_to @post
    end

    def unlike  
        @post = Post.find(params[:id])
        Like.find_by(likeable_id: @post.id, user_id: current_user.id, likeable_type: "Post").destroy
        redirect_to @post
    end

    private
end