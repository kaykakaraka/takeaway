require 'menu'
require 'messenger'

class Order
  def initialize(menu) #menu is an object of the menu class
    @menu = menu
    @order = {}
    @complete = false
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
      @order.each { |item, price|
        total += @menu.in_pence(item) 
        price.insert(0, "£") if price[0] != "£"
     }
    @order["Total"] = in_pounds(total)
  end

  def receipt
    receipt = Receipt.new(@order)
    receipt.format
  end

  def complete
    fail "You have not selected any items." if @order.empty?
    @complete = true
    return "Thank you! Your order has been placed."
  end

  def text(client)
    fail "Your order is not completed" if @complete == false
    messenger = Messenger.new(client)
    messenger.text
  end
end