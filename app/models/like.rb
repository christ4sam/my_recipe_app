class Like < ActiveRecord::Base
  belongs_to :chef
  belongs_to :recipe
  
  #this line ensures that a chef will like or dislike a recipe only once
  validates_uniqueness_of :chef, scope: :recipe   
end