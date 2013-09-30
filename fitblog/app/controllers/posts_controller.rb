class PostsController < ApplicationController

  before_action :require_authentication
  skip_before_action :require_authentication, only: [:index, :show]

  def index
    @posts = Post.all.page params[:page]
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).order('created_at DESC')

    @steps = fitbit_client.data_by_time_range("/activities/tracker/steps", {:base_date => "#{@post.post_date}", :period => "1d"})['activities-tracker-steps'][0]['value']
    temp_total_minutes = fitbit_client.sleep_on_date(@post.post_date)['sleep'][0]['minutesAsleep'].to_i
    temp_hours = temp_total_minutes/60
    temp_minutes = temp_total_minutes % 60
    @sleep = temp_hours.to_s + 'h ' + temp_minutes.to_s + 'm'
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
      redirect_to root_url
    end
  end

  def update
    @post = Post.find(params[:id])
    #@post.title = params(post[:title])
    #@post.body = params(post[:body])
    if @post.update(post_params)
      flash[:notice] = 'Post updated.'
      redirect_to root_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = 'Post deleted.'
      redirect_to root_url
    end
  end
  
  private_class_method
    def post_params
      params.require(:post).permit(:title, :post_date, :body)
    end
end
