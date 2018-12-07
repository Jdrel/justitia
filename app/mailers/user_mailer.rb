class UserMailer < ApplicationMailer
  def new_consultation(consultation)
    @consultation = consultation
    @lawyer = @consultation.lawyer
    client = @consultation.client
    @lawyer_name = @lawyer.user.first_name + " " + @lawyer.user.last_name
    @client_name = client.user.first_name + " " + client.user.last_name
    lawyer_email = @lawyer.user.email
    mail(
      :subject => "You've got a new consultation with #{@client_name}",
      :to  => lawyer_email,
      :from => 'hello@justitia.today',
      :html_body => "You've got a new consultation with #{@client_name}",
      :track_opens => 'true')
  end
end
