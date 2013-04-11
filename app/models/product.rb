class Product < ActiveRecord::Base
  attr_accessible :name, :price, :review

	validates_uniqueness_of :name
	validates_presence_of :name

  has_many :reviews
end
