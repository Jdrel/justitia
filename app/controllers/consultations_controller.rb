class ConsultationsController < ApplicationController

  def new
    @consultation = Consultation.new
    @lawyer = Lawyer.find(params[:lawyer_id])
    @client = current_user.client
  end

  def create
    customer = Stripe::Customer.create({
    source: params[:stripeToken],
    email:  params[:stripeEmail]
    })
    client = current_user.client
    client.stripe_id = customer.id
    client.save
    lawyer = Lawyer.find(params[:lawyer_id])
    consultation = Consultation.new
    consultation.lawyer = lawyer
    consultation.client = client
    consultation.save

    redirect_to lawyer_consultation_path(lawyer, consultation)
  end

  def show
    @consultation = Consultation.find(params[:id])
    account_sid = ENV['TWILIO_SID']
    api_key = ENV['TWILIO_KEY']
    api_secret = ENV['TWILIO_SECRET']
    # Create Video grant for our token
    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = "Consultation-#{@consultation.id}"
    @video_room = video_grant.room
    identity = current_user.email
    # Create an Access Tokenss
    token = Twilio::JWT::AccessToken.new(
      account_sid,
      api_key,
      api_secret,
      [video_grant],
      identity: identity
    )
    # Assigning token to instance variable that is passed to the view
    @twilio_token = token.to_jwt
    start_consultation if current_user.lawyer == @consultation.lawyer
    end

  def start_consultation
    @consultation.start_time = Time.new if @consultation.start_time.nil?
    @consultation.save
  end
end
