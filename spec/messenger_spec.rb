require "messenger"

RSpec.describe Messenger do
  it "sends a text" do
    fake_client = double :client
    from = ENV['TWILIO_NUMBER']
    to = ENV['MY_NUMBER']
    expect(fake_client).to receive(:new).with(ENV['TWILIO_ID'], ENV['TWILIO_AUTH_TOKEN']).and_return(fake_client)
    expect(fake_client).to receive(:messages).and_return(fake_client)
    expect(fake_client).to receive(:create).with(
      from: from,
      to: to,
      body: "Thank you! Your order was placed and will be delivered before 18:52"
      )
      .and_return("Thank you! Your order was placed and will be delivered before 18:52")
    messenger = Messenger.new(fake_client)
    expect(messenger.text).to eq "Thank you! Your order was placed and will be delivered before 18:52"
  end
end