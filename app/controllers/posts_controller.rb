class PostsController < ApplicationController
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

  def edit
    @post = Post.find(params[:id]) 
  end

  def update
    # binding.pry
    @post = Post.find(params[:id])
    if @post.update(post_params)
    # if @post.update(params[:post])
      flash[:notice] = "The post updated."
      redirect_to posts_path
    else
      render :edit
    end
  end



  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit!
  end

end
