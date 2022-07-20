class OrdersController < ApplicationController
  before_action :login_check,except: [:delivery_confirm,:confirm_del]

  def index
    @order = Order.where("user_id = ? AND status <> 'delivered'",current_user.id)
  end
  def create
    order =Order.new(order_params)
    # order.order_items.new(order_item_params)
    if order.save
      param = order_item_params
      param["order_id"]=order.id
      if OrderItem.create(param)
        redirect_to(orders_index_path)
      else
        order.destroy
      end
    end
    # puts order.id
  end

  def order_history
    @order = Order.where("user_id = ? AND status = 'delivered'",current_user.id)
  end

  def delivery_confirm
    @order = Order.where("status = 'active'")
  end

  def confirm_del
      order = Order.find(params[:id])
      order.update(:status => "delivered")
      redirect_to(delivery_confirm_orders_path)
  end

  def cancel
    order = Order.find(params[:id])
    order.update(:status => "cancelled")
    redirect_to(orders_index_path)
  end
  def show
    @order = Order.find(params[:id])
    sql = "SELECT *,order_items.id FROM order_items INNER JOIN products  ON
            order_items.product_id = products.id AND order_items.order_id=#{params[:id]}
            INNER JOIN product_packs
            ON order_items.product_pack_id = product_packs.id"
      @order_derails =  ActiveRecord::Base.connection.execute(sql)
  end

  private
  def order_params
    weight = ProductPack.find(params[:product][:product_pack_id])
    t_price =total_price(weight.pack_weight,weight.weight_type,params[:product][:quantity],params[:product][:price_per_kg])
    tax_and_total_to_pay(t_price)
    parm = {:user_id => current_user.id,:total_amount => t_price,:tax => tax_and_total_to_pay(t_price)[0],
    :total_to_pay =>tax_and_total_to_pay(t_price)[1] ,:status => 'active' }
  end
  def order_item_params
    params.require(:product).permit(:product_id,:product_pack_id,:quantity)
  end
end
