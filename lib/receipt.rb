class Receipt
  def initialize(order) #order is a hash representing the ordered items and prices
    @order = order
  end

  def format
    receipt = []
    @order.each do |item, price|
      receipt << "#{item} (#{price})"
    end
    receipt
  end
end