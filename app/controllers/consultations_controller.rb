class ConsultationsController < ApplicationController
  TW_ACCOUNT_SID = ENV['TWILIO_SID']
  TW_API_KEY = ENV['TWILIO_KEY']
  TW_API_SECRET = ENV['TWILIO_SECRET']
  TW_TOKEN = ENV['TWILIO_TOKEN']

  # INSTANT CONSULTATIONS
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
    set_basic_details_for_new_consultation
    @consultation.save
    UserMailer.new_consultation(@consultation).deliver_now
    redirect_to lawyer_consultation_path(@lawyer, @consultation)
  end

  # FUTURE CONSULTATIONS (i.e. appointments)
  def new_appointment
    @consultation = Consultation.new
    @client = current_user.client
    @lawyer = Lawyer.find(params[:lawyer_id])
    @ask_for_credit_card = true
    if !@client.stripe_id.nil?
      @ask_for_credit_card = false
    elsif @lawyer.should_the_lawyer_give_a_free_consult?(@client)
      @ask_for_credit_card = false
    end
  end

  def create_new_appointment
    set_basic_details_for_new_consultation
    @consultation.appointment_time = params[:appointment_time]
    @consultation.appointment_status = "pending"
    @consultation.save
    redirect_to appointment_confirmation_path(@lawyer, @consultation)
  end

  # SHOW PAGE OF APPOINTMENT CONFIRMATION
  def appointment_confirmation
    @consultation = Consultation.find(params[:id])
    @lawyer = Lawyer.find(params[:lawyer_id])
  end

  # METHOD THAT ALLOWS THE LAWYER TO CHANGE THE STATUS OF THE APPOINTMENT AND SENDS AN EMAIL  TO BOTH PARTIES
  def update_appointment_status
    @consultation = Consultation.find(params[:id])
    @lawyer = @consultation.lawyer
    @consultation.appointment_status = params[:appointment_status]
    @consultation.save
    UserMailer.appointment_status_updated_client(@consultation).deliver_now
    pre_appointment_email_moment = @consultation.appointment_time - 3600 # 1 hour before the appointment time
    if params[:appointment_status] == "accepted"
      if pre_appointment_email_moment > Time.now
        UserMailer.pre_appointment_email_client(@consultation.id).deliver_later(wait_until: pre_appointment_email_moment)
        UserMailer.pre_appointment_email_lawyer(@consultation.id).deliver_later(wait_until: pre_appointment_email_moment)
      else
        UserMailer.pre_appointment_email_client(@consultation.id).deliver_later(wait: 5.seconds)
        UserMailer.pre_appointment_email_lawyer(@consultation.id).deliver_later(wait: 5.seconds)
      end
    end
  end

  # PAGE WHERE CLIENT AND USER HAVE A CALL
  def show
    @consultation = Consultation.find(params[:id])
    authorize(@consultation)
    # Assigning token to instance variable that is passed to the view
    token = twilio_token
    @twilio_token = token.to_jwt
    start_consultation if current_user.lawyer == @consultation.lawyer
  end

  def end_videocall
    @consultation = Consultation.find(params[:id])
    unless @consultation.start_time.nil? || @consultation.payment_status == "free" # consultation has happened or the call is not free
      if @consultation.payment_status == 'pending' # first_one to close the call
        charge_the_client_and_close_the_room
      end
    else # There is a payment
      if @consultation.start_time.nil? # The consultation never happened
      @consultation.duration = 0
      @consultation.payment_status = 'cancelled'
      @consultation.save
      elsif @consultation.payment_status = "free" # The consultation was free
      @consultation.duration = Time.now - @consultation.start_time
      @consultation.save
      end
    end
  end

  private

  def start_consultation
    @consultation.start_time = Time.new if @consultation.start_time.nil?
    @consultation.save
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

  def charge_the_client_and_close_the_room
    @consultation.duration = Time.now - @consultation.start_time
    @consultation.client_amount = @consultation.calculate_client_amount
    charge = Stripe::Charge.create(
    customer: @consultation.client.stripe_id,
    amount: @consultation.client_amount.cents,
    currency: @consultation.client_amount_currency,
    description: "Consultation: #{@consultation.id} #{current_user.email}"
    )
    @consultation.payment_status = 'paid'
    @consultation.client_payment = charge.to_json
    @consultation.save
    # close the room
    @client = Twilio::REST::Client.new(TW_ACCOUNT_SID, TW_TOKEN)
    room = @client.video.rooms("Consultation-#{@consultation.id}").update(status: 'completed')
  end

  def set_basic_details_for_new_consultation
    # Setting the Stripe details, lawyer and creating the consultation.
    @client = current_user.client
    @lawyer = Lawyer.find(params[:lawyer_id])
    if @client.stripe_id.nil? && !@lawyer.should_the_lawyer_give_a_free_consult?(@client)
      customer = Stripe::Customer.create({
        source: params[:stripeToken],
        email:  params[:stripeEmail]
      })
      @client.stripe_id = customer.id
      @client.save
    end
    @consultation = Consultation.new
    @consultation.lawyer = @lawyer
    @consultation.client = @client
    if @lawyer.should_the_lawyer_give_a_free_consult?(@client)
      @consultation.payment_status = 'free'
    end
  end
end
