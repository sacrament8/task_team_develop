class AgendaMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.agenda_mailer.delete_agenda_notification.subject
  #
  def delete_agenda_notification(agenda, user)
    @agenda = agenda
    @user = user
    mail to: @user.email, subject: "チーム: #{@agenda.team.name}のアジェンダ: #{@agenda.title}が削除されました"
  end
end
