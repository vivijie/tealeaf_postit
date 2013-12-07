class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit; end

  def update
    # binding.pry
    if @post.update(post_params)
    # if @post.update(params[:post])
      flash[:notice] = "The post updated."
      redirect_to posts_path
    else
      render :edit
    end
  end



  def show
    @comment = Comment.new
  end

  private
  def post_params
    params.require(:post).permit(:title, :url)
  end

  def set_post
    @post = Post.find(params[:id]) 
  end

end
