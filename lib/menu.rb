class Menu
  def initialize
    @menu = {"Thai Green Curry with tofu" => "£6.80",
            "Thai Green Curry with vegetables" => "£6.30",
            "Thai Red Curry with tofu" => "£6.80",
            "Thai Red Curry with vegetables" => "£6.30",
            "Phad Mee Trang" => "£7.10",
            "Vegetable Spring Rolls" => "£3.00",
            "Steamed Rice" => "£2.30",
            "Vegetable Rice" => "£2.60",
            }
  end

  def show
   @menu
  end

  def price(item)
    price = @menu[item]
  end

  def in_pence(item)
    price = @menu[item]
    price.slice!(0)
    (price.to_f * 100).round
  end
end