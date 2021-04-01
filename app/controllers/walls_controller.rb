class WallsController < ApplicationController
    def index
        #this will be the homepage
        #later restrict to just wall posts
        @posts = Post.all
    end
end
