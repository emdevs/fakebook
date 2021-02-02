class PostsController < ApplicationController
    def index #timeline feature
        #only posts of signed in author and their friends
    end

    def show
        @post = Post.find(params[:id])
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

    private

    def post_params
        params.require(:post).permit(:title, :body, :likes)
    end

end
