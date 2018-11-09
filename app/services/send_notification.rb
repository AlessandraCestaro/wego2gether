class SendNotification
  ACCOUNT_SID = 'AC1142847a8ac49efc08fa52bff82b91a9'
  AUTH_TOKEN = '8b9d2f5e6c5f097e8384aee21bb39c05'

  WHITELIST_WHATSAPP = [
    '+393452504867',
    '+33609885198',
    '+4917681139769',
    '+393342900726',
  ]

  def initialize(user, trip)
    @user = user
    @trip = trip
    url = "http://wego2gether.club/trips/#{@trip.id}/user_trips/#{@user.id}"
    @body = "You've been invited to a trip by #{@trip.user.first_name}. Click here: #{url}"
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  def send_invitation
    if WHITELIST_WHATSAPP.include?(@user.phone_number)
      self.send_invitation_whatsapp
    else
      self.send_invitation_sms
    end
  end

  def send_invitation_whatsapp
    @client.messages.create(
      body: @body,
      from: 'whatsapp:+14155238886',
      to: "whatsapp:#{@user.phone_number}"
    )
  end

  def send_invitation_sms
    @client.messages.create(
      body: @body,
      from: '+14155238886',
      to: "#{@user.phone_number}"
    )
  end
end
