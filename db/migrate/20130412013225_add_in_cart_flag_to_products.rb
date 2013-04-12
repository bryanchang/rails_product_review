class AddInCartFlagToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :in_cart_flag, :boolean
  end
end
