class ConsultationsController < ApplicationController
  TW_ACCOUNT_SID = ENV['TWILIO_SID']
  TW_API_KEY = ENV['TWILIO_KEY']
  TW_API_SECRET = ENV['TWILIO_SECRET']

  def index
    @lawyer = Lawyer.find(params[:lawyer_id])
    @consultations = Consultation.where(lawyer: @lawyer)
  end

  def new
    @consultation = Consultation.new
    @lawyer = Lawyer.find(params[:lawyer_id])
    @client = current_user.client
  end

  def create
    client = current_user.client
    if client.stripe_id.nil?
      customer = Stripe::Customer.create({
      source: params[:stripeToken],
      email:  params[:stripeEmail]
      })
      client.stripe_id = customer.id
      client.save
    end
    lawyer = Lawyer.find(params[:lawyer_id])
    consultation = Consultation.new
    consultation.lawyer = lawyer
    consultation.client = client
    consultation.save
    UserMailer.new_consultation(consultation).deliver_now
    redirect_to lawyer_consultation_path(lawyer, consultation)
  end

  def appointment_status
    @consultation = Consultation.find(params[:id])
    @lawyer = @consultation.lawyer
    @consultation.appointment_status = params[:appointment_status]
    @consultation.save
    respond_to do |format|
      format.js
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
    # Create Video grant for our token
    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = "Consultation-#{@consultation.id}"
    @video_room = video_grant.room
    # Create an Access Token
    token = twilio_token
    # Assigning token to instance variable that is passed to the view
    @twilio_token = token.to_jwt
    start_consultation if current_user.lawyer == @consultation.lawyer
  end

  def start_consultation
    @consultation.start_time = Time.new if @consultation.start_time.nil?
    @consultation.video_room = @video_room
    @consultation.save
  end

  def end_videocall
    @consultation = Consultation.find(params[:id])

    unless @consultation.start_time.nil?
      @consultation.duration = Time.now - @consultation.start_time
      @consultation.client_amount_cents = calculate_client_amount

      charge = Stripe::Charge.create(
      customer: @consultation.client.stripe_id,
      amount: @consultation.client_amount_cents,
      currency: @consultation.client_amount_currency,
      description: "Consultation: #{@consultation.id}"
      )

      @consultation.payment_status = 'paid'
      @consultation.client_payment = charge.to_json
    else
      @consultation.duration = 0
      @consultation.payment_status = 'cancelled'
    end

    # close the room
    @client = Twilio::REST::Client.new(TW_ACCOUNT_SID, twilio_token)
    room = @client.video.rooms(@consultation.video_room).update(status: 'completed')
    @consultation.save
  end

  def calculate_client_amount
    rate = @consultation.lawyer.calculate_5mins_rate
    minutes = (@consultation.duration/60)
    five_minutes_block = (minutes/5).abs
    (rate * five_minutes_block + rate) * 100
  end

  def twilio_token
    identity = current_user.email
    Twilio::JWT::AccessToken.new(
      TW_ACCOUNT_SID,
      TW_API_KEY,
      TW_API_SECRET,
      [video_grant],
      identity: identity
    )
  end
end
