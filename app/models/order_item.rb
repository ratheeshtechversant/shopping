class OrderItem < ApplicationRecord
  belongs_to :product_pack
  belongs_to :order
  belongs_to :product
  validates :quantity,:product_pack_id,:product_id,:order_id, presence: true
end
