module ApplicationHelper



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
    private
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
end
