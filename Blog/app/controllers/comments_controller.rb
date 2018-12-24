class CommentsController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        @comments = @post.comments.create(params[:commnet]).permit(:name,:commnet)
        redirect_to post_path(@post)

    end

    def destroy
        
    end
    
    
end
