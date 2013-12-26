class CategoriesController < ApplicationController
  before_action :require_user, only:[:new, :create]
  before_action :set_category, only:[:show, :update, :edit]

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

  def edit; end

  def update
  	if @category.update(category_params)
  	  flash[:notice] = "The category update!"
  	  redirect_to categories_path
    else
      render :edit
    end
  end

  def show; end


  private
  def category_params
  	params.require(:category).permit!
  end

  def set_category
    @category = Category.find_by slugs: params[:id]
  end
end