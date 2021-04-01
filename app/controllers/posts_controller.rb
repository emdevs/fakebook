class PostsController < ApplicationController
    # def index #timeline feature: only your own and friends posts
    #     ids = [current_user.id] + current_user.friends_ids
    #     @posts = Post.where(user_id: ids).order('created_at DESC')
    # end

    #Need to update this page to accomodate club.posts.build and wall.posts.build

    def show
        @post = Post.find(params[:id])

        #generate new comment obj, for "new comment form" in post#show
        @comment = current_user.comments.build
    end

    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            flash[:alert] = "Post successfully created."
            redirect_to @post
        else
            render :new
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(post_params)
            flash[:alert] = "Post succesfully saved."
            redirect_to @post
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.image.purge
        @post.destroy

        redirect_to root_path
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

    def post_params
        params.require(:post).permit(:title, :body, :image)
    end

end
