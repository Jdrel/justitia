# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/new_consultation
  def new_consultation
    UserMailer.new_consultation
  end
  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_consultation
  def user_consultation
    UserMailer.user_consultation
  end
end
