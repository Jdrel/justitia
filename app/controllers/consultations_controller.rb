class ConsultationsController < ApplicationController
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

  def end_videocall
    @consultation = Consultation.find(params[:id])
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
    @consultation.save
  end

  def calculate_client_amount
    rate = @consultation.lawyer.calculate_5mins_rate
    minutes = (@consultation.duration/60)
    five_minutes_block = (minutes/5).abs
    (rate * five_minutes_block + rate) * 100
  end
end
