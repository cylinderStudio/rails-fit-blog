class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
    
    user_id = User.find(session[:user_id]).id

    # @comment = @post.comments.create(params[:comment].permit(:text))
    @comment = @post.comments.new
    @comment.post_id = params[:post_id]
    @comment.user_id = user_id
    @comment.text = params[:comment][:text]
    @comment.save
    redirect_to post_path(@post)
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	def comment_params
		# TODO: how to do strong parameters in this case?
	end
end
