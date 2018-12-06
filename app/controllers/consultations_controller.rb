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

  def appointment_status
    @consultation = Consultation.find(params[:id])
    @lawyer = @consultation.lawyer
    @consultation.appointment_status = params[:appointment_status]
    @consultation.save
    respond_to do |format|
      format.js
    end
  end
end
