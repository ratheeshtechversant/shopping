class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  validates :quantity,:product_pack_id,:product_id,:cart_id, presence: true
end
