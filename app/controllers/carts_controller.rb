class CartsController < ApplicationController
  before_action :login_check
  before_action :cart_data ,only: [:index, :checkout, :confirm_order]
  def index
  end

  def checkout
  end

  def confirm_order
    order = Order.new(order_params)
    if order.save
      cart = Cart.find_by(user_id:current_user.id)
      cart.cart_items.each do |x|
        order.order_items.create(product_id:x.product_id, product_pack_id:x.product_pack_id, quantity:x.quantity)
        x.destroy
      end
      redirect_to(orders_index_path)
    end

  end

  def cart_data
    @cart = Cart.find_by(user_id:current_user.id)
    if @cart.present?
      sql = "SELECT *,cart_items.id FROM cart_items INNER JOIN products  ON
              cart_items.product_id = products.id AND cart_items.cart_id=#{@cart.id}
              INNER JOIN product_packs
              ON cart_items.product_pack_id = product_packs.id"
        @carts =  ActiveRecord::Base.connection.execute(sql)
    end
  end

  private
  def order_params
    parm = {:user_id => current_user.id,:total_amount => sum_total(@carts),:tax => tax(@carts),
    :total_to_pay =>total_to_pay(@carts) ,:status => 'active' }
  end

end
