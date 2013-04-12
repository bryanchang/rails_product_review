class Review < ActiveRecord::Base
  attr_accessible :body, :product_id, :rating, :product

  validates_length_of :body, :minimum => 50, :maximum => 1000
  validates_size_of :rating, :minimum => 0, :maximum => 5

  belongs_to :product 
end
