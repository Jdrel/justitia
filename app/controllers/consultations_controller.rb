class ConsultationsController < ApplicationController
  TW_ACCOUNT_SID = ENV['TWILIO_SID']
  TW_API_KEY = ENV['TWILIO_KEY']
  TW_API_SECRET = ENV['TWILIO_SECRET']
  TW_TOKEN = ENV['TWILIO_TOKEN']

  def index
    @lawyer = Lawyer.find(params[:lawyer_id])
    authorize(@lawyer)
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
    # if authenticate_lawyer
      @consultation = Consultation.find(params[:id])
      @lawyer = @consultation.lawyer
      @consultation.appointment_status = params[:appointment_status]
      @consultation.save
      respond_to do |format|
        format.js
      end
    # else
    #   redirect_to lawyers_path
    # end
  end

  # def authenticate_lawyer
  #   lawyer = Lawyer.find(params[:lawyer_id])
  #   current_user.id == lawyer.user.id
  # end

  def show
    @consultation = Consultation.find(params[:id])
    authorize(@consultation)
    # Assigning token to instance variable that is passed to the view
    token = twilio_token
    @twilio_token = token.to_jwt
    start_consultation if current_user.lawyer == @consultation.lawyer
  end

  def start_consultation
    @consultation.start_time = Time.new if @consultation.start_time.nil?
    @consultation.save
  end

  def end_videocall
    @consultation = Consultation.find(params[:id])

    unless @consultation.start_time.nil? # consultation has happened
      if @consultation.payment_status == 'pending' # first_one to close the call

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

        # close the room
        @client = Twilio::REST::Client.new(TW_ACCOUNT_SID, TW_TOKEN)
        room = @client.video.rooms("Consultation-#{@consultation.id}").update(status: 'completed')
        @consultation.save
      end

    else # the lawyer has not arrived
      @consultation.duration = 0
      @consultation.payment_status = 'cancelled'
      @consultation.save
    end


  end

  def calculate_client_amount
    rate = @consultation.lawyer.calculate_5mins_rate
    minutes = (@consultation.duration / 60)
    five_minutes_block = (minutes / 5).abs
    (rate * five_minutes_block + rate) * 100
  end

  def new_appointment
    @consultation = Consultation.new
  end

  def create_new_appointment
    @consultation = Consultation.new
    lawyer = Lawyer.find(params[:lawyer_id])
    @consultation.lawyer = lawyer
    @consultation.start_time = params[:start_time]
    @consultation.client = current_user.client
    @consultation.save
    # UserMailer.user_consultation(@consultation).deliver_now
    redirect_to confirmation_path(lawyer, @consultation)
  end

  def confirmation
    @consultation = Consultation.find(params[:id])
    @lawyer = Lawyer.find(params[:lawyer_id])
  end

  def twilio_token
    # Create Video grant for our token
    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = "Consultation-#{@consultation.id}"
    @video_room = video_grant.room
    # Create an Access Token
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
