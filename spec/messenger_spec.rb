require "messenger"

RSpec.describe Messenger do
  it "calculates the time the delivery will arrive" do
    fake_sms_server = double :server
    fake_time = double :time, now: Time.new(2022,5,27, 12,11,45) 
    messenger = Messenger.new(fake_sms_server, fake_time)
    expect(messenger.arrival_time(fake_time)).to eq "12:41"
  end

  it "sends a text" do
    fake_sms_server = double :client
    fake_time = double :time, now: Time.new(2022,5,27, 12,11,45)
    from = ENV['TWILIO_NUMBER']
    to = ENV['MY_NUMBER']
    expect(fake_sms_server).to receive(:new).with(ENV['TWILIO_ID'], ENV['TWILIO_AUTH_TOKEN']).and_return(fake_sms_server)
    expect(fake_sms_server).to receive(:messages).and_return(fake_sms_server)
    expect(fake_sms_server).to receive(:create).with(
      from: from,
      to: to,
      body: "Thank you! Your order was placed and will be delivered before 12:41"
      )
      .and_return("Thank you! Your order was placed and will be delivered before 12:41")
    messenger = Messenger.new(fake_sms_server, fake_time)
    expect(messenger.text).to eq "Thank you! Your order was placed and will be delivered before 12:41"
  end
end