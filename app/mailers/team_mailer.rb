class TeamMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.team_mailer.change_owner_notification.subject
  #
  def change_owner_notification(user_id, team)
    @team = team
    @user = User.find(user_id)
    mail to: @user.email, subject: "#{@team.name}チームのオーナーがあなたに変更されました"
  end
end
