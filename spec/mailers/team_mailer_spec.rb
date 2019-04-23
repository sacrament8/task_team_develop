require "rails_helper"

RSpec.describe TeamMailer, type: :mailer do
  describe "change_owner_notification" do
    let(:mail) { TeamMailer.change_owner_notification }

    it "renders the headers" do
      expect(mail.subject).to eq("Change owner notification")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
