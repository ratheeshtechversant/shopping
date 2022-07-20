class ProductPack < ApplicationRecord
  belongs_to :product
  has_one :order_item
end
