require "messenger"

RSpec.describe Messenger do
  it "sends a text" do
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
    messenger = Messenger.new(fake_client)
    expect(messenger.text(fake_time)).to eq "Thank you! Your order was placed and will be delivered before 12:41"
  end

  it "calculates the time the delivery will arrive" do
    fake_client = double :client
    fake_time = double :time, now: Time.new(2022,5,27, 12,11,45) 
    messenger = Messenger.new(fake_client)
    expect(messenger.arrival_time(fake_time)).to eq "12:41"
  end
end