class ConsultationsController < ApplicationController
  TW_ACCOUNT_SID = ENV['TWILIO_SID']
  TW_API_KEY = ENV['TWILIO_KEY']
  TW_API_SECRET = ENV['TWILIO_SECRET']
  TW_TOKEN = ENV['TWILIO_TOKEN']

# OVERVIEW FOR THE LAWYER DASHBOARD
def index
  @lawyer = Lawyer.find(params[:lawyer_id])
  authorize(@lawyer)
  @consultations = Consultation.where(lawyer: @lawyer)
  @consultations = @consultations.where.not(appointment_time: nil)
end

# INSTANT CONSULTATIONS
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
    @lawyer = Lawyer.find(params[:lawyer_id])
    @client = current_user.client
    @ask_for_credit_card = true
    if !@client.stripe_id.nil?
      @ask_for_credit_card = false
    elsif @lawyer.should_the_lawyer_give_a_free_consult?(@client)
      @ask_for_credit_card = false
    end
  end

  def create_new_appointment
    set_basic_details_for_new_consultation
    @consultation.appointment_status = "pending"
    @consultation.appointment_time = params[:appointment_time]
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
    if @consultation.duration.nil? # making sure that only one participant closes the room
      case [@consultation.start_time.nil?, @consultation.payment_status]
      when [true, 'pending'] # The consultation never happened because the client stopped it before the lawyer entered
        @consultation.duration = 0
        @consultation.payment_status = 'cancelled'
        @consultation.save
      when [false, 'pending'] # The consultation happened and we need to charge the client
        set_consultation_duration
        charge_the_client
        @consultation.save
        close_twilio_room
      when [false, 'free'] # The consultation happened, however the consultation was free
        set_consultation_duration
        @consultation.save
        close_twilio_room
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

  def set_consultation_duration
    @consultation.duration = Time.now - @consultation.start_time
  end

  def close_twilio_room
    @client = Twilio::REST::Client.new(TW_ACCOUNT_SID, TW_TOKEN)
    room = @client.video.rooms("Consultation-#{@consultation.id}").update(status: 'completed')
  end

  def charge_the_client
    @consultation.client_amount = @consultation.calculate_client_amount
    @consultation.lawyer_amount = @consultation.calculate_platform_amount

    #create token for connected account
    token = Stripe::Token.create({
      :customer => @consultation.client.stripe_id,
    }, {:stripe_account => @consultation.lawyer.stripe_id})

    charge = Stripe::Charge.create({
      source: token.id,
      amount: @consultation.client_amount.cents,
      currency: @consultation.client_amount_currency,
      description: "Consultation: #{@consultation.id} #{current_user.email}",
      :application_fee => @consultation.lawyer_amount.cents
      }, :stripe_account => @consultation.lawyer.stripe_id)
    @consultation.payment_status = 'paid'
    @consultation.client_payment = charge.to_json
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
