class ProductsController < ApplicationController
  before_action :login_check ,except: :index
  def index
    @product = Product.all
  end
  def buynow
    @product = Product.find(params[:id])
    @weight = @product.product_packs.all


  end
  def addcart
    @product = Product.find(params[:id])
    @weight = @product.product_packs.all
    @cart = Cart.find_by(user_id:current_user.id)
    if !@cart.present?
      @cart = Cart.create(user_id:current_user.id)
    end
    if CartItem.where("cart_id = ? AND product_id = ?",@cart.id,@product.id).present?
      redirect_to(carts_path)
    end
  end

  end
