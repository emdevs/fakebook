class CommentsController < ApplicationController
    def new
    end

    def create

        #comment isnt being created
        @comment = current_user.comments.build(comment_params)

        if @comment.save
            #how to get post_id? redirec tnot working
            redirect_to post_path(@post.id)
        else
            redirect_to root_path
        end
    end

    def destroy
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :post_id)
    end
end
