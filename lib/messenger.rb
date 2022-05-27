require 'twilio-ruby'
class Messenger
  def initialize(client, time)
    @client = client
    @time = time
  end

  def arrival_time(time)
    arrival_time = time.now + 60 * 30
    return arrival_time.strftime("%k:%M") 
  end

  def text
    arrival = arrival_time(@time)
    account_sid = ENV['TWILIO_ID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = @client.new(account_sid, auth_token)

    from = ENV['TWILIO_NUMBER']
    to = ENV['MY_NUMBER']

    client.messages.create(
    from: from,
    to: to,
    body: "Thank you! Your order was placed and will be delivered before #{arrival}"
    )
  end
end

=begin
messenger = Messenger.new(Twilio::REST::Client)
messenger.text(Time)
=end



