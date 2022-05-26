class Receipt
  def initialize(order) #order is a hash representing the ordered items and prices
    # ...
  end

  def price(items) # items is an array (of floats?)representing prices 
    # calculates total price
  end

  def format
    # returns an itemised receipt as a string
    # calls the price method
  end
end