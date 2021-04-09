class PostsController < ApplicationController
    prepend_before_action :load_postable, except: [:like, :dislike]
    prepend_before_action :load_postable_for_like, only: [:like, :unlike]

    before_action :require_owner, only: [:edit, :update, :destroy]
    
    def show
        @post = Post.find(params[:id])
        #generate new comment obj, for "new comment form" in post#show
        @comment = @post.comments.new
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
        # @post = Post.find(params[:id])
        Like.create(user_id: current_user.id, likeable_id: @post.id, likeable_type: "Post")
        redirect_to [@postable_name, @post]
    end

    def unlike  
        # @post = Post.find(params[:id])
        Like.find_by(likeable_id: @post.id, user_id: current_user.id, likeable_type: "Post").destroy
        redirect_to [@postable_name, @post]
    end

    protected

    def post_params
        params.require(:post).permit(:title, :body, :image)
    end

    def load_postable
        resource, id = request.path.split("/")[1,2]
        @postable = resource.singularize.classify.constantize.find(id)
        #specifically for routes.
        @postable_name = @postable
    end

    def load_postable_for_like
        #singular (ONLY wall/posts) and plural (clubs/1/posts) routes handled here, because all types of post likes will route to post#like
        @post = Post.find(params[:id])
        @postable = @post.postable_type.classify.constantize.find(@post.postable_id)
        @postable_name = (@postable.class == Wall)? "wall" : @postable 
    end

    def require_owner
        @post = Post.find(params[:id])
        unless (current_user.id == @post.user_id)
            #make into flash[:error] later
            flash[:alert] = "You do not have the permission to edit this post"
            redirect_to [@postable_name, @post]
        end
    end
end
