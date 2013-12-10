class Category < ActiveRecord::Base
  has_many		:post_categories	
  has_many		:posts, through: :post_categories

  validates 	:name, presence: true

  validates_each :name do |record, attr, value|
  	record.errors.add attr, 'starts with z.' if value.to_s[0] == 'z'
  end
end