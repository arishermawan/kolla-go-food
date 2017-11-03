require 'rails_helper'

describe OrderMailer do

  describe "received message" do
    let(:order) {create(:order) }
    let(:mail) {OrderMailer.received(order)}

    it "sends confirmation email when order is received" do
      expect(mail.subject).to eq("Go Food Order Confirmation")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq(["go.scholarship.kolla@gmail.com"])
    end
  end

  describe "shipped message" do
    let(:order) {create(:order) }
    let(:mail) {OrderMailer.shipped(order)}

    it "sends confirmation email when order is shipped" do
      expect(mail.subject).to eq("Go Food Order Shipped")
      expect(mail.to).to eq([order.email])
      expect(mail.from).to eq(["go.scholarship.kolla@gmail.com"])
    end

  end

end
