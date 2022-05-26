require 'menu'

class Order
  def initialize(menu) #menu is an object of the menu class
    @menu = menu
    @order = {}
  end

  def menu
    @menu.show
  end

  def select(order)
    @order.delete("Total")
    @order[order] = @menu.price(order) #adds the selected item to the order
    total
    return @order
  end

  def in_pounds(num) #num is an integer
    num = num.to_s
    num.insert(-3, ".")
    num.insert(0, "£")
  end
  
  def total
    total = 0
    @order.each {|item, price|
      total += @menu.in_pence(item) 
      price.insert(0, "£") if price[0] != "£"
    }
    @order["Total"] = in_pounds(total)
  end

  def receipt
    @order
  end

  def complete
    return "Thank you! Your order has been placed."
    # throws an error if there are no items
  end

  def text(number) #number is a string representing a phone number
    # send a text message
    # throws an error if the order is not complete
  end
end