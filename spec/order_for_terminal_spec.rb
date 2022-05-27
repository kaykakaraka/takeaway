require "order_for_terminal" 

  hash = {"Thai Green Curry with tofu" => "£6.80",
  "Thai Green Curry with vegetables" => "£6.30",
  "Thai Red Curry with tofu" => "£6.80",
  "Thai Red Curry with vegetables" => "£6.30",
  "Phad Mee Trang" => "£7.10",
  "vegetable Spring Rolls" => "£3.00",
  "Steamed Rice" => "£2.30",
  "Vegetable Rice" => "£2.60",
  }
  
RSpec.describe OrderForTerminal do
   xit "puts the menu" do
    order_for_terminal = OrderForTerminal.new
    io = double :io
    expect(io).to_receive(:puts).with(hash)
   end
end