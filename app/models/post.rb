class Post < ActiveRecord::Base
  belongs_to	:creator, foreign_key: 'user_id', class_name: 'User'
  has_many		:comments
  has_many		:post_categories
  has_many		:categories, through: :post_categories
  has_many		:votes, as: :voteable

  validates 	:title, :url, :description, presence: true


  def total_votes
  	self.up_votes - self.down_votes
  end

  def up_votes
    votes.where(vote: true).size
  end

  def down_votes
    votes.where(vote: false).size
  end
end

