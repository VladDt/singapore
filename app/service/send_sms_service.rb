class SendSmsService

  def initialize(number)
    @number = number
  end

  def call
    @client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
    @client.api.account.messages.create(
      from: '+380979808343',
      to: @number,
      body: 'You have 1 new doctor account to approve'
      )
  end

end