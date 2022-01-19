require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  describe "user_order_email" do
    let(:mail) { OrderMailer.user_order_email }

    it "renders the headers" do
      expect(mail.subject).to eq("User order email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "ware_house_order_email" do
    let(:mail) { OrderMailer.ware_house_order_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Ware house order email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
