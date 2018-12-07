class UserMailer < ApplicationMailer

  def new_consultation(consultation)
    @consultation = consultation
    @lawyer = @consultation.lawyer
    client = @consultation.client
    @lawyer_name = @lawyer.user.first_name + " " + @lawyer.user.last_name
    @client_name = client.user.first_name + " " + client.user.last_name

    mail(to: @lawyer.user.email, subject: "You've got a new consultation with #{@client_name}")
    # This will render a view in `app/views/user_mailer`!
  end
end
