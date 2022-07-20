class ApplicationController < ActionController::Base
  before_action :cart_count
  helper_method :total_price, :pack_details

  def pack_details(pack_id)
    ProductPack.find(pack_id)
  end

  def total_price(weight,type,quantity,price)
    price = price.to_i
    quantity  = quantity.to_i
    weight = weight.to_f
    if type == "G"
      total = price*quantity*(weight/1000)
      total
    else
      weight*quantity*price
    end
  end
  def tax_and_total_to_pay(total)
    tax = (total*10)/100
    total_to_pay = tax + total
    return tax,total_to_pay
  end

  def sum_total(cart)
       sum_1(cart)
    end

    def tax(cart)
      x = sum_1(cart)
      (x*10)/100
    end
    def total_to_pay(cart)
      sum_1(cart) + tax(cart)
    end

    def sum_1(cart)
      sum = 0
      cart.each do |x|
        if x["weight_type"]  == "G"
          xx = x["pack_weight"].to_f
          sum += (xx/1000)*x["quantity"]*x["price_per_kg"]
        else
          sum += x["pack_weight"]*x["quantity"]*x["price_per_kg"]
        end
      end
      return sum
    end

  def cart_count
    if user_signed_in?
      if Cart.find_by("user_id = ?",current_user.id)
      cart = Cart.find_by("user_id = ?",current_user.id)
      @cart_count = CartItem.where("cart_id = ?",cart.id).count
      else
        @cart_count = 0
      end
    else
      @cart_count = 0
    end
  end

  private
  def login_check
    if !user_signed_in?
      flash[:notice] = "You need to Sign-In first"
      # redirect_to(root_path)
      redirect_to(new_user_session_path)
    end
  end
end
