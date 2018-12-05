class ConsultationsController < ApplicationController

  def new
    @consultation = Consultation.new
    @lawyer = Lawyer.find(params[:lawyer_id])
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

  end
end
