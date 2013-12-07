class CommentsController < ApplicationController
  def create
  	binding.pry
  	@post = Post.find(params[:post_id])
  	@comment = Comment.new(params.require(:comment).permit(:body))
  	@comment.post = @post
  	@comment.user_id = 1

  	if @comment.save
  	  flash[:notice] = "Your coment was added."
  	  redirect_to post_path(@post)
  	else
  	  render 'posts/show'
  	end
  end

end