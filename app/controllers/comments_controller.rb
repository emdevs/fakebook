class CommentsController < ApplicationController
    before_action :load_postable, except: [:like, :unlike]
    before_action :load_postable_for_like, only: [:like, :unlike]

    def create
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            flash[:alert] = "Comment successfully created!"
            redirect_to [@postable_name, @post]
        else
            flash[:error] = @comment.errors.full_messages
            #FOR NOW (might want to render :new somehow)
            redirect_to [@postable_name, @post]
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:alert] = "Comment successfully deleted"
        redirect_to [@postable_name, @post]
    end

    def like
        @comment = Comment.find(params[:id])
        Like.create(user_id: current_user.id, likeable_id: @comment.id, likeable_type:"Comment")
        redirect_to [@postable_name, @post]
    end

    def unlike  
        @comment = Comment.find(params[:id])
        Like.find_by(user_id: current_user.id, likeable_id: @comment.id, likeable_type:"Comment").destroy
        redirect_to [@postable_name, @post]
    end

    protected

    def load_postable
        resource, resource_id = request.path.split("/")[1,2]
        post_id = request.path.split("/")[4]
        @post = Post.find(post_id)
        @postable = resource.singularize.classify.constantize.find(resource_id)
        #Allows wall and plural polymorphic models to use the same routes when redirecting
        @postable_name = @postable
    end

    def load_postable_for_like
        @post = Post.find(params[:post_id])
        #will return error in like and unlike if post is wrong id for the comment
        @postable = @post.postable_type.classify.constantize.find(@post.postable_id)
        @postable_name = (@postable.class == Wall)? "wall" : @postable 
    end


    def comment_params
        params.require(:comment).permit(:body)
    end
end
