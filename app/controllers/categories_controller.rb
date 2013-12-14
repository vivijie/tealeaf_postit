class CategoriesController < ApplicationController
  before_action :require_user, only:[:new, :create]

  def index
  	@categories = Category.all
  end

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(category_params)
    
  	if @category.save
  	  flash[:notice] = "Category ceated!"
  	  redirect_to categories_path
  	else
  	  render :new
  	end
  end

  def edit
  	@category = Category.find(params[:id])
  end

  def update
  	@category = Category.find(params[:id])
  	if @category.update(category_params)
  	  flash[:notice] = "The category update!"
  	  redirect_to categories_path
    else
      render :edit
    end
  end

  def show
    @category = Category.find(params[:id])
  end


  private
  def category_params
  	params.require(:category).permit!
  end
end