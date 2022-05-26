require 'order'
require 'receipt'
require 'messenger'

RSpec.describe "Takeaway" do
  
  it "shows the menu" do
    menu = Menu.new
    order = Order.new(menu)
    menu_list = {"Thai Green Curry with tofu" => "£6.80",
                  "Thai Green Curry with vegetables" => "£6.30",
                  "Thai Red Curry with tofu" => "£6.80",
                  "Thai Red Curry with vegetables" => "£6.30",
                  "Phad Mee Trang" => "£7.10",
                  "Vegetable Spring Rolls" => "£3.00",
                  "Steamed Rice" => "£2.30",
                  "Vegetable Rice" => "£2.60",
                  }
    expect(order.menu).to eq menu_list
  end
  
  it "shows you your current order" do
    menu = Menu.new
    order = Order.new(menu)
    hash = {"Vegetable Rice" => "£2.60", "Total" => "£2.60"}
    expect(order.select("Vegetable Rice")).to eq hash
  end

  it "shows a longer current order" do
    menu = Menu.new
    order = Order.new(menu)
    hash = {"Vegetable Rice" => "£2.60", "Vegetable Spring Rolls" => "£3.00", "Total" => "£5.60"}
    order.select("Vegetable Rice")
    expect(order.select("Vegetable Spring Rolls")).to eq hash
  end

  xit "creates a receipt" do
    order = OrderCreator.new
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    order.select("Thai Red Curry with tofu")
    expect(order.receipt).to eq "Vegetable Rice (2.60),
                                Vegetable Spring Rolls (£3.00),
                                Thai Red Curry with tofu (£6.80),
                                Total = £12.40"
  end

  it "tells you the order has been placed" do
    menu = Menu.new
    order = Order.new(menu)
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    order.select("Thai Red Curry with tofu")
    expect(order.complete).to eq "Thank you! Your order has been placed."
  end
  
end
