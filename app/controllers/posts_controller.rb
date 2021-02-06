class PostsController < ApplicationController
    def index #timeline feature
        @posts = Post.all
        #only posts of signed in author and their friends
    end

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
            #flash msg, successfully created?
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
            #flash msg, successfully updated?
            redirect_to @post
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to root_path
    end

    def like
        @post = Post.find(params[:id])

        Like.create(user_id: current_user.id, post_id: @post.id)
        redirect_to @post
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

end
