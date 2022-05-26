require 'order'

hash = {"Thai Green Curry with tofu" => "£6.80",
        "Thai Green Curry with vegetables" => "£6.30",
        "Thai Red Curry with tofu" => "£6.80",
        "Thai Red Curry with vegetables" => "£6.30",
        "Phad Mee Trang" => "£7.10",
        "vegetable Spring Rolls" => "£3.00",
        "Steamed Rice" => "£2.30",
        "Vegetable Rice" => "£2.60",
        }

RSpec.describe Order do
  it "shows the menu" do
    fake_menu = double :menu, show: hash
    order = Order.new(fake_menu)
    expect(order.menu).to eq hash
  end

  xit "shows your selection so far" do
    fake_menu = double :menu, show: hash, price: "£2.60"
    order = Order.new(fake_menu)
    order.menu
    order_so_far = {"Vegetable Rice" => "£2.60", "Total" => "£2.60"}
    expect(order.select("Vegetable Rice")).to eq order_so_far
  end
end

