# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user/welcome_email
  def welcome_email
    user_id = User.last.id
    UserMailer.welcome_email(user_id)
  end
end
