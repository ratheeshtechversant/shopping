class Product < ApplicationRecord
  has_many :product_packs
  has_many :cart_items
  has_many :carts ,through: :cart_items
  has_many :order_items
  has_many :orders ,through: :order_items
end
