require 'order_for_terminal'

hash = {"Thai Green Curry with tofu" => "£6.80",
        "Thai Green Curry with vegetables" => "£6.30",
        "Thai Red Curry with tofu" => "£6.80",
        "Thai Red Curry with vegetables" => "£6.30",
        "Phad Mee Trang" => "£7.10",
        "Vegetable Spring Rolls" => "£3.00",
        "Steamed Rice" => "£2.30",
        "Vegetable Rice" => "£2.60",
        }

RSpec.describe "intergration with order for terminal class" do

  it "puts the menu" do
    io = double :io
    order_for_terminal = OrderForTerminal.new(io, Twilio::REST::Client, Receipt, Time, Messenger)
    expect(io).to receive(:puts).with(hash)
    order_for_terminal.begin
  end

  it "allows the user to select an item" do
    io = double :io
    order_for_terminal = OrderForTerminal.new(io, Twilio::REST::Client, Receipt, Time, Messenger)
    expect(io).to receive(:puts).with(hash)
    allow(io).to receive(:puts).with("Enter 'select' to make a selection")
    allow(io).to receive(:puts).with("Enter 'receipt' to view your receipt")
    allow(io).to receive(:puts).with("Enter 'confirm' to confirm your order")
    allow(io).to receive(:puts).with("Enter 'text' to receive a text confirmation")
    allow(io).to receive(:puts).with("Enter 'stop' to exit.")
    expect(io).to receive(:gets).and_return("select")
    expect(io).to receive(:puts).with("Please select an item by typing its name")
    expect(io).to receive(:gets).and_return("Vegetable Rice")
    allow(io).to receive(:puts).with({"Vegetable Rice" => "£2.60", "Total" => "£2.60"})
    expect(io).to receive(:gets).and_return("")
    expect(io).to receive(:gets).and_return("stop")
    order_for_terminal.begin
    order_for_terminal.select_options
  end

  xit "allows the user to view their receipt" do
    io = double :io
    order_for_terminal = OrderForTerminal.new(io, Twilio::REST::Client, Receipt, Time, Messenger)
    expect(io).to receive(:puts).with(hash)
    allow(io).to receive(:puts).with("Enter 'select' to make a selection")
    allow(io).to receive(:puts).with("Enter 'receipt' to view your receipt")
    allow(io).to receive(:puts).with("Enter 'confirm' to confirm your order")
    allow(io).to receive(:puts).with("Enter 'text' to receive a text confirmation")
    allow(io).to receive(:puts).with("Enter 'stop' to exit.")
    expect(io).to receive(:gets).and_return("select")
    expect(io).to receive(:puts).with("Please select an item by typing its name")
    expect(io).to receive(:gets).and_return("Vegetable Rice")
    expect(io).to receive(:puts).with({"Vegetable Rice" => "£2.60", "Total" => "£2.60"})
    expect(io).to receive(:gets).and_return("Vegetable Spring Rolls")
    expect(io).to receive(:puts).with({"Vegetable Rice" => "£2.60", "Vegetable Spring Rolls" => "£3.00", "Total" => "£5.60"})
    expect(io).to receive(:gets).and_return("")
    expect(io).to receive(:gets).and_return("receipt")
    expect(io).to receive(:puts).with(["Vegetable Rice (£2.60)",
                                      "Vegetable Spring Rolls (£3.00)",
                                      "Total (£5.60)"])
    order_for_terminal.begin
    order_for_terminal.select_options                                
  end

  xit "allows the user to send a text" do
    io = double :io
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
    order_for_terminal = OrderForTerminal.new(io, fake_client, Receipt, fake_time, Messenger)
    expect(io).to receive(:puts).with(hash)
    allow(io).to receive(:puts).with("Enter 'select' to make a selection")
    allow(io).to receive(:puts).with("Enter 'receipt' to view your receipt")
    allow(io).to receive(:puts).with("Enter 'confirm' to confirm your order")
    allow(io).to receive(:puts).with("Enter 'text' to receive a text confirmation")
    allow(io).to receive(:puts).with("Enter 'stop' to exit.")
    expect(io).to receive(:gets).and_return("select")
    expect(io).to receive(:puts).with("Please select an item by typing its name")
    expect(io).to receive(:gets).and_return("Vegetable Rice")
    expect(io).to receive(:puts).with({"Vegetable Rice" => "£2.60", "Total" => "£2.60"})
    expect(io).to receive(:gets).and_return("")
    expect(io).to receive(:gets).and_return("confirm")
    expect(io).to receive(:puts).with("Thank you! Your order has been placed.")
    expect(io).to receive(:gets).and_return("text")
    order_for_terminal.begin
    expect(order_for_terminal.select_options).to_return "Thank you! Your order was placed and will be delivered before 12:41"
  end

end