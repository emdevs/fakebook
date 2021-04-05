class CommentsController < ApplicationController
    #for a comment (which will always belong to a post, it needs postable_type, postable_id, post_id)
    before_action :load_postable

    def create
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user

        if @comment.save
            flash[:alert] = "Comment successfully created!"
            redirect_to [@postable_name, @post]
        else
            #how to render errors for a form partial in another controllers view with the url of post#show
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


    #implement later
    def like
        @comment = Comment.find(params[:comment_id])
        @post = Post.find(@comment.post_id)
        Like.create(user_id: current_user.id, likeable_id: @comment.id, likeable_type:"Comment")
        redirect_to @post
    end

    def unlike  
        @comment = Comment.find(params[:comment_id])
        @post = Post.find(@comment.post_id)
        Like.find_by(user_id: current_user.id, likeable_id: @comment.id, likeable_type:"Comment").destroy
        redirect_to @post
    end

    protected

    #need to grab postable obj from url.
    def load_postable
        resource, resource_id = request.path.split("/")[1,2]
        post_id = request.path.split("/")[4]

        @post = Post.find(post_id)
        @postable = resource.singularize.classify.constantize.find(resource_id)
        #Allows wall and plural polymorphic models to use the same routes when redirecting
        @postable_name = @postable
    end


    def comment_params
        params.require(:comment).permit(:body)
    end
end
