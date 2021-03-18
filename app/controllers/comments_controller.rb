class CommentsController < ApplicationController
    def new #not really needed actually, can only create comment from inside posts contorller show
    end

    def create
        @comment = current_user.comments.build(comment_params)

        if @comment.save
            #flash msg comment created?
            redirect_to post_path(@comment.post_id)
        else
            #how to render errors for a form partial in another controllers view with the url of post#show
            flash[:alert] = @comment.errors.full_messages
            redirect_to post_path(@comment.post_id)

        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:alert] = "Comment successfully deleted"
        redirect_to post_path(@comment.post_id)
    end

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

    private

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end
end
