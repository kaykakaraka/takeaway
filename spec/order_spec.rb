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

  it "shows your selection so far" do
    fake_menu = double :menu, show: hash, price: "£2.60", in_pence: 260
    order = Order.new(fake_menu)
    order.menu
    order_so_far = {"Vegetable Rice" => "£2.60", "Total" => "£2.60"}
    expect(order.select("Vegetable Rice")).to eq order_so_far
  end

  it 'converts an integer to pounds' do
    fake_menu = double :menu
    order = Order.new(fake_menu)
    expect(order.in_pounds(1260)).to eq "£12.60"
  end

  context "when user tries to complete the order when they have no items" do
    it "fails" do
      fake_menu = double :menu
      order = Order.new(fake_menu)
      expect {order.complete}.to raise_error "You have not selected any items."
    end
  end

  context "when user tries to send a text and order is not complete" do
    it "fails" do
      fake_menu = double :menu
      fake_client = double :client
      fake_time = double :time, now: Time.new(2022,5,27, 12,11,45) 
      order = Order.new(fake_menu)
      expect {order.text(fake_client, fake_time)}.to raise_error "Your order is not completed"
    end
  end
end

