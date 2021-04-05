class Walls::CommentsController < CommentsController
    before_action :load_postable

    private

    def load_postable
        post_id = request.path.split("/")[3]
        @post = Post.find(post_id)
        @postable_name = "wall"
    end
end