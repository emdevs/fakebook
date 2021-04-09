class Walls::PostsController < PostsController
    #overwrite @postable
    prepend_before_action :load_postable

    def index
        @posts = Post.where(postable_type: "Wall").order("created_at DESC")
    end

    private

    def load_postable
        @postable = Wall.find(1)
        @postable_name = "wall"
    end
end