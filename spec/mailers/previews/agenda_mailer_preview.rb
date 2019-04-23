# Preview all emails at http://localhost:3000/rails/mailers/agenda_mailer
class AgendaMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/agenda_mailer/delete_agenda_notification
  def delete_agenda_notification
    AgendaMailerMailer.delete_agenda_notification
  end

end
