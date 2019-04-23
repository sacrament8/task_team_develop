# Preview all emails at http://localhost:3000/rails/mailers/team_mailer
class TeamMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/team_mailer/change_owner_notification
  def change_owner_notification
    TeamMailerMailer.change_owner_notification
  end

end
