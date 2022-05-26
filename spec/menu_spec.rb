require "menu"

RSpec.describe Menu do
  it "shows the menu" do
    menu = Menu.new
    list = {"Thai Green Curry with tofu" => "£6.80",
                    "Thai Green Curry with vegetables" => "£6.30",
                    "Thai Red Curry with tofu" => "£6.80",
                    "Thai Red Curry with vegetables" => "£6.30",
                    "Phad Mee Trang" => "£7.10",
                    "Vegetable Spring Rolls" => "£3.00",
                    "Steamed Rice" => "£2.30",
                    "Vegetable Rice" => "£2.60",
                    }
    expect(menu.show).to eq list
  end

  it "selects the price of a single item" do
    menu = Menu.new
    expect(menu.price("Steamed Rice")).to eq "£2.30"
  end

  it "returns the cost in pence as an integer of an item" do
    menu = Menu.new
    expect(menu.in_pence("Steamed Rice")).to eq 230
  end
end                        