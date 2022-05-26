{{PROBLEM}} Multi-Class Planned Design Recipe

1. Describe the Problem

As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.
    - likely to use a hash; name and price

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.
     - be able to pick the dish

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.
      - this one needs to use the twilio-gem and doubles

2. Design the Class System

Consider diagramming out the classes and their relationships. Take care to focus on the details you see as important, not everything. The diagram below uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com

   ┌──────────────────────────────┐                ┌───────────────────────────────┐
   │                              │                │                               │
   │  OrderCreator                │                │  Receipt                      │
   │                              │                │                               │
   │  shows menu                  │                │  makes a list of ordered      │
   │  select items                ├────────────────┤  adds up the total            │
   │  add up price                │                │                               │
   │  shows receipt               │                │                               │
   │                              │                │                               │
   └─────────────┬────────────────┘                └───────────────────────────────┘
                 │
                 │
                 │
                 │
                 │
   ┌─────────────┴────────────────┐
   │ Messenger                    │
   │                              │
   │ sends a text                 │
   │ generates a time             │
   │ tells when to expect order   │
   │                              │
   └──────────────────────────────┘

class OrderCreator
  def initialize(number) #number is a string representing a phone number
    # ...
  end

  def menu
    # returns the menu
    # menu items are numbered
  end

  def select(order) order is a string representing an item in the hash
    # adds item to the order
    # shows total order so far

  def receipt
    # returns an itemised receipt as a string
    # creates the receipt object at this moment
  end

  def complete
    # returns "Thank you! Your order has been placed."
    # throws an error if there are no items
  end

  def text(number) #number is a string representing a phone number
    # send a text message
    # throws an error if the order is not complete
  end
end

class Messenger
  def initialize(number) #number is a string representing a phone number
     #calculates time now
  end

  def arrival_time
    #calculates time order will arrive
  end
  
  def text
     # sends a text
     # format is like "Thank you! Your order was placed and will be delivered before 18:52"
  end
end

class Receipt
  def initialize(order) #order is a hash representing the ordered items and prices
    # ...
  end

  def price(items) # items is an array (of floats?)representing prices 
    # calculates total price
  end

  def format
    # returns an itemised receipt as a string
    # calls the price method
  end
end

3. Create Examples as Integration Tests

Create examples of the classes being used together in different situations and combinations that reflect the ways in which the system will be used.

# EXAMPLE

# 1 - Creates a receipt for an order
order = OrderCreator.new
order.select("Vegetable Rice")
order.select("Vegetable Spring Rolls")
order.select("Thai Red Curry with tofu")
expect(order.receipt).to eq "Vegetable Rice (2.60),
                            Vegetable Spring Rolls (£3.00),
                            Thai Red Curry with tofu (£6.80),
                            Total = £12.40"

# 2 - returns a string when order if completed

order = OrderCreator.new
order.menu
order.select("Vegetable Rice")
order.select("Vegetable Spring Rolls")
order.select("Thai Red Curry with tofu")
expect(order.complete).to eq "Thank you! Your order has been placed."

# 3 - sends a text message for an order
order = OrderCreator.new
order.menu 
order.select("Vegetable Rice")
order.select("Vegetable Spring Rolls")
order.select("Thai Red Curry with tofu")
order.complete
expect(order.text).to eq "Thank you! Your order was placed and will be delivered before {A TIME CALCULATED}"


"Thank you! Your order was placed and will be delivered before 18:52"

# 4 Shows the order so far when an item is selected (uses receipt invisibly)
order = OrderCreator.new
expect(order.select("Vegetable Rice").to eq {"Vegetable Rice": "£2.60",
                                             "Total" = "£2.60"}

4. Create Examples as Unit Tests

# 1 - ORDER: Shows a menu
order = OrderCreator.new(07755440022)
order.menu = {"Thai Green Curry with tofu": "£6.80",
              "Thai Green Curry with vegetables": "£6.30",
              "Thai Red Curry with tofu": "£6.80",
              "Thai Red Curry with vegetables": "£6.30",
              "Phad Mee Trang": "£7.10",
              "vegetable Spring Rolls": "£3.00",
              "Steamed Rice": "£2.30",
              "Vegetable Rice": "£2.60",
              }

# 2 RECEIPT: returns a receipt
receipt = Receipt.new({"Thai Green Curry with tofu": "£6.80",
                       "Thai Green Curry with vegetables": "£6.30"})
expect(receipt.format).to eq "Thai Green Curry with tofu (£6.80),
                              Thai Green Curry with vegetables (£6.30),
                              Total = £13.10"

# 3 RECEIPT: calculates a total price
receipt = Receipt.new({"Thai Green Curry with tofu": "£6.80",
                       "Thai Green Curry with vegetables": "£6.30"})
expect(receipt.price).to eq "13.10"

# 4 MESSENGER: calculates a time

messenger = Messenger.new(07724405517)
expect

# 5 MESSENGER: sends a text message

5. Implement the Behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.