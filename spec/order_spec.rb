require 'order'

hash = {"Thai Green Curry with tofu" => "£6.80",
        "Thai Green Curry with vegetables" => "£6.30",
        "Thai Red Curry with tofu" => "£6.80",
        "Thai Red Curry with vegetables" => "£6.30",
        "Phad Mee Trang" => "£7.10",
        "Vegetable Spring Rolls" => "£3.00",
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

  it 'creates a receipt' do
    fake_receipt_class = double :Receipt
    fake_menu = double :menu, show: hash
    expect(fake_menu).to receive(:price).with("Vegetable Rice").and_return("£2.60")
    expect(fake_menu).to receive(:price).with("Vegetable Spring Rolls").and_return("£3.00")
    allow(fake_menu).to receive(:in_pence).with("Vegetable Rice").and_return(260)
    allow(fake_menu).to receive(:in_pence).with("Vegetable Spring Rolls").and_return(300)
    order = Order.new(fake_menu)
    order.select("Vegetable Rice")
    order.select("Vegetable Spring Rolls")
    expect(fake_receipt_class).to receive(:new)
      .with({"Vegetable Rice" => "£2.60", "Vegetable Spring Rolls" => "£3.00", "Total" => "£5.60"})
      .and_return(fake_receipt_class)
      expect(fake_receipt_class).to receive(:format)
      .and_return(["Vegetable Rice (£2.60)",
                    "Vegetable Spring Rolls (£3.00)",
                    "Total (£5.60)"])
    expect(order.receipt(fake_receipt_class)).to eq ["Vegetable Rice (£2.60)",
                                                      "Vegetable Spring Rolls (£3.00)",
                                                      "Total (£5.60)"]
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
      fake_sms_server = double :server
      fake_messenger = double :messenger
      fake_time = double :time, now: Time.new(2022,5,27, 12,11,45) 
      order = Order.new(fake_menu)
      expect {order.text(fake_sms_server, fake_time, fake_messenger)}.to raise_error "Your order is not completed"
    end
  end

  it "sends a text" do
    fake_menu = double :menu, show: hash
    expect(fake_menu).to receive(:price).with("Vegetable Rice").and_return("£2.60")
    allow(fake_menu).to receive(:in_pence).with("Vegetable Rice").and_return(260)
    fake_sms_server = double :server
    fake_time = double :time
    fake_messenger = double :messenger, text: "Thank you! Your order was placed and will be delivered before 12:41"
    expect(fake_messenger).to receive(:new).with(fake_sms_server, fake_time)
      .and_return(fake_messenger)
    order = Order.new(fake_menu)
    order.select("Vegetable Rice")
    order.complete
    expect(order.text(fake_sms_server, fake_time, fake_messenger)).to eq "Thank you! Your order was placed and will be delivered before 12:41"
  end  

  it "removes any item that isn't on the menu" do
    fake_menu = double :menu, show: hash, price: "£2.60", in_pence: 260
    order = Order.new(fake_menu)
    order.menu
    order_so_far = {"Vegetable Rice" => "£2.60", "Total" => "£2.60"}
    order.select("lemonade")
    expect(order.select("Vegetable Rice")).to eq order_so_far
  end
end


