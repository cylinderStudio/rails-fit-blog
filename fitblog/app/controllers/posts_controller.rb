class PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  
  def new
  	@post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = 'Post saved.'
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params(post[:title])
    @post.body = params(post[:body])
    if @post.save
      flash[:notice] = 'Post updated.'
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post deleted.'
      render 'index'
    end
  end
  
  private_class_method
    def post_params
      params.require(:post).permit(:title, :post_date, :body)
    end
end
