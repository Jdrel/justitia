class UserMailer < ApplicationMailer
  def consultation_information(consultation)
    consultation = Consultation.last
    @consultation = consultation
    @lawyer = @consultation.lawyer
    @client = @consultation.client
    @lawyer_name = @lawyer.user.first_name + " " + @lawyer.user.last_name
    @client_name = @client.user.first_name + " " + @client.user.last_name
    @lawyer_email = @lawyer.user.email
    @client_email = @client.user.email
  end

  def new_consultation
    consultation_information(@consultation)
    mail(
      :subject => "You've got a new consultation with #{@client_name}",
      :to  => @lawyer_email,
      :from => 'hello@justitia.today',
      :html_body => "You've got a new consultation with #{@client_name}",
      :track_opens => 'true')
  end

  def user_consultation
    consultation_information(@consultation)
    mail(
      :subject => "Your consultation with #{@lawyer_name}",
      :to  => @client_email,
      :from => 'hello@justitia.today',
      :html_body => "Your consultation with #{@lawyer_name}",
      :track_opens => 'true')
  end
end
