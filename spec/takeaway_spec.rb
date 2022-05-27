require 'order'
require 'receipt'
require 'messenger'

RSpec.describe "Takeaway integration" do
  
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

  it "creates a receipt" do
    menu = Menu.new
    order = Order.new(menu)
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    order.select("Thai Red Curry with tofu")
    receipt = ["Vegetable Rice (£2.60)",
              "Vegetable Spring Rolls (£3.00)",
              "Thai Red Curry with tofu (£6.80)",
              "Total (£12.40)"]
    receipt_class = Receipt
    expect(order.receipt(receipt_class)).to eq receipt
  end

  it "tells you the order has been placed" do
    menu = Menu.new
    order = Order.new(menu)
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    order.select("Thai Red Curry with tofu")
    expect(order.complete).to eq "Thank you! Your order has been placed."
  end

  it "gives the total cost of the order" do
    menu = Menu.new
    order = Order.new(menu)
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    expect(order.total).to eq "£5.60"
  end

  it "sends a text to confirm the order" do
    menu = Menu.new
    order = Order.new(menu)
    messenger_class = Messenger
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    order.complete
    fake_client = double :client
    fake_time = double :time, now: Time.new(2022,5,27, 12,11,45) 
    from = ENV['TWILIO_NUMBER']
    to = ENV['MY_NUMBER']
    expect(fake_client).to receive(:new).with(ENV['TWILIO_ID'], ENV['TWILIO_AUTH_TOKEN']).and_return(fake_client)
    expect(fake_client).to receive(:messages).and_return(fake_client)
    expect(fake_client).to receive(:create).with(
      from: from,
      to: to,
      body: "Thank you! Your order was placed and will be delivered before 12:41"
      )
      .and_return("Thank you! Your order was placed and will be delivered before 12:41")
    expect(order.text(fake_client, fake_time, messenger_class)).to eq "Thank you! Your order was placed and will be delivered before 12:41"
  end
end
