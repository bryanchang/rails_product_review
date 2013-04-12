require 'open-uri'

class Product < ActiveRecord::Base
  attr_accessible :name, :price, :review

	validates_uniqueness_of :name
	validates_presence_of :name

	validates_presence_of :price

  has_many :reviews

  def api(name)
  	file = open("https://www.googleapis.com/shopping/search/v1/public/products?key=AIzaSyAypfaGqJYG0kPrsTGhzfZN2VXg0JcRS-0&country=US&q=#{URI.escape(name)}&alt=json", :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
	JSON.load(file.read)
  end

  def api_image(name)
  	file = open("https://www.googleapis.com/shopping/search/v1/public/products?key=AIzaSyAypfaGqJYG0kPrsTGhzfZN2VXg0JcRS-0&country=US&q=#{URI.escape(name)}&alt=json", :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
	JSON.load(file.read)["items"][0]["product"]["images"][0]["link"]
  end

  def api_description(name)
  	file = open("https://www.googleapis.com/shopping/search/v1/public/products?key=AIzaSyAypfaGqJYG0kPrsTGhzfZN2VXg0JcRS-0&country=US&q=#{URI.escape(name)}&alt=json", :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE)
	JSON.load(file.read)["items"][0]["product"]["description"]
  end

end
