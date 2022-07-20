class CartItemsController < ApplicationController
  before_action :login_check

  def create
     if CartItem.create(cart_params)
     redirect_to(root_path)
   end

 end

 def edit
   @cart_item = CartItem.find(params[:id])
   @product = Product.find(@cart_item.product_id)
   @weight = @product.product_packs.all
 end

 def update
   # @cart = Cart.all
   @cart_item = CartItem.find(params[:id])
   puts @cart_item
   puts cart_update_params
   if @cart_item.update(cart_update_params)
     redirect_to(carts_path)
   end
 end

 def destroy
   puts params[:id]
   cart = CartItem.find(params[:id])
   if cart.destroy
     redirect_to(carts_path)
   end
 end

 private
 def cart_update_params
   cart_up_params = params.require(:cart_item).permit(:product_pack_id,:quantity)
   cart_up_params["product_pack_id"] = params[:product][:product_pack_id]
   cart_up_params
 end
 def cart_params
   params.require(:product).permit(:cart_id, :product_id,:product_pack_id,:quantity)
 end
end
