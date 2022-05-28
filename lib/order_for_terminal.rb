$LOAD_PATH << File.dirname(__FILE__)
require 'order'
require 'menu'
require 'receipt'
require 'messenger'

class OrderForTerminal

  def initialize(io, sms_server, receipt_class, time, messenger_class)
   @io = io
   @sms_server = sms_server
   @receipt_class = receipt_class
   @time = time
   @messenger_class = messenger_class
  end

  def begin 
    menu = Menu.new
    @order = Order.new(menu)
    menu = @order.menu
    @io.puts menu
  end

  def give_options
    @io.puts "Enter 'select' to make a selection"
    @io.puts "Enter 'receipt' to view your receipt"
    @io.puts "Enter 'confirm' to confirm your order"
    @io.puts "Enter 'text' to receive a text confirmation"
    @io.puts "Enter 'stop' to exit."
    @command = @io.gets.chomp
  end

  def select_options
    give_options
      loop do
        break if @command == "stop"
        if @command == 'select'
          select
        elsif @command == 'receipt'
          @io.puts(@order.receipt(receipt_class))
        elsif @command == 'confirm'
          @io.puts(@order.complete)
        elsif @command == 'text'
          @order.text(@sms_server, @time, @messenger_class)
        end
      give_options
      end
  end

  def select
    @io.puts "Please select an item by typing its name"
    item = @io.gets.chomp
      while !item.empty?
        @io.puts(@order.select(item))
        item = @io.gets.chomp
      end
  end

end


=begin
order = OrderForTerminal.new(Kernel, Twilio::REST::Client, Receipt, Time, Messenger) 
order.begin
order.select_options
=end