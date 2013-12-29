


# Using normal metaprogramming
# module Voteable
#   def self.included(base)
#   	base.send(:include, InstanceMethods)
# 	base.extend ClassMethods
# 	base.class_eval do
#       my_class_method
# 	end 
#   end
 
#   module InstanceMethods
# 	def total_votes
# 	  self.up_votes - self.down_votes
# 	end

# 	def up_votes
# 	  votes.where(vote: true).size
# 	end

# 	def down_votes
# 	  votes.where(vote: false).size
# 	end
#   end

#   module ClassMethods
#     def my_class_method
#       has_many :votes, as: :voteable
#     end
#   end
# end