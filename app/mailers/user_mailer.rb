class UserMailer < ApplicationMailer
  def consultation_information(consultation)
    @consultation = consultation
    @lawyer = @consultation.lawyer
    @client = @consultation.client
    @lawyer_name = @lawyer.user.full_name
    @client_name = @client.user.full_name
    @lawyer_email = @lawyer.user.email
    @client_email = @client.user.email
  end

  # instant consultation
  def new_consultation(consultation)
    consultation_information(consultation)
    mail(
      :subject => "You've got a new consultation with #{@client_name}",
      :to  => @lawyer_email,
      :from => 'hello@justitia.today',
      :html_body => "You've got a new consultation with #{@client_name}",
      :track_opens => 'true')
  end
  def appointment_status_updated_client(consultation)
    consultation_information(consultation)
    mail(
      :subject => "Your consultation with #{@lawyer_name}",
      :to  => @client_email,
      :from => 'hello@justitia.today',
      :html_body => "Your consultation with #{@lawyer_name}",
      :track_opens => 'true')
  end

  def pre_appointment_email_client(consultation_id)
    consultation = Consultation.find(consultation_id)
    consultation_information(consultation)
    mail(
      :subject => "You have a call today with #{@lawyer_name} at #{@consultation.appointment_time.strftime('%A, %b %d')}",
      :to  => @client_email,
      :from => 'hello@justitia.today',
      :html_body => "You have a call today with #{@lawyer_name} at #{@consultation.appointment_time.strftime('%A, %b %d')}",
      :track_opens => 'true')
  end

  def pre_appointment_email_lawyer(consultation_id)
    consultation = Consultation.find(consultation_id)
    consultation_information(consultation)
    mail(
      :subject => "You have a call today with #{@client_name} at #{@consultation.appointment_time.strftime('%A, %b %d')}",
      :to  => @lawyer_email,
      :from => 'hello@justitia.today',
      :html_body => "You have a call today with #{@client_name} at #{@consultation.appointment_time.strftime('%A, %b %d')}",
      :track_opens => 'true')
  end
end
