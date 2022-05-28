require "order_for_terminal" 

  hash = {"Thai Green Curry with tofu" => "£6.80",
  "Thai Green Curry with vegetables" => "£6.30",
  "Thai Red Curry with tofu" => "£6.80",
  "Thai Red Curry with vegetables" => "£6.30",
  "Phad Mee Trang" => "£7.10",
  "Vegetable Spring Rolls" => "£3.00",
  "Steamed Rice" => "£2.30",
  "Vegetable Rice" => "£2.60",
  }
  
RSpec.describe OrderForTerminal do
   it "puts the menu" do
    io = double :io
    fake_server = double :server
    fake_receipt_class = double :receipt
    fake_time = double :time
    fake_messenger = double :messenger
    order_for_terminal = OrderForTerminal.new(io, fake_server, fake_receipt_class, fake_time, fake_messenger)
    expect(io).to receive(:puts).with(hash)
    order_for_terminal.begin
   end
end