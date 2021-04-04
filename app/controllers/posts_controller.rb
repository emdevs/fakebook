class PostsController < ApplicationController
    before_action :load_postable

    def show
        @post = Post.find(params[:id])
        #generate new comment obj, for "new comment form" in post#show
        # @comment = current_user.comments.build
    end

    def new
        @post = @postable.posts.new
    end

    def create
        @post = @postable.posts.build(post_params)
        @post.user = current_user

        if @post.save
            flash[:alert] = "Post successfully created."
            redirect_to [@postable_name, :posts]
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
            redirect_to [@postable_name, @post]
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.image.purge
        @post.destroy

        redirect_to [@postable_name, :posts]
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

    protected

    def load_postable
        resource, id = request.path.split("/")[1,2]
        @postable = resource.singularize.classify.constantize.find(id)
        #specifically for routes.
        @postable_name = @postable
    end

    def post_params
        params.require(:post).permit(:title, :body, :image)
    end
end
