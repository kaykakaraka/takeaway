require 'twilio-ruby'
class Messenger
  def initialize(client)
    @client = client
  end

  def arrival_time
    #calculates time order will arrive
  end

  def text
    account_sid = ENV['TWILIO_ID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = @client.new(account_sid, auth_token)

    from = ENV['TWILIO_NUMBER']
    to = ENV['MY_NUMBER']

    client.messages.create(
    from: from,
    to: to,
    body: "Thank you! Your order was placed and will be delivered before 18:52"
    )
  end
end

=begin
messenger = Messenger.new(Twilio::REST::Client)
messenger.text
=end




