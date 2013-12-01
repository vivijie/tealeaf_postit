class AddCategoryToPostCategories < ActiveRecord::Migration
  def change
  	rename_column :post_categories, :categroy_id, :category_id
  end
end
