require 'rails_helper'

RSpec.describe MembershipMailer, type: :mailer do
  describe 'organization_campaign_email >' do
    let(:user) { FactoryGirl.create(:user) }
    let(:subject) { 'Share Your World 2016' }
    let(:body) { 'Hi mom!' }
    let(:mail) do
      described_class.organization_campaign_email(
        user, [user.email], subject, body
      ).deliver_now
    end

    it 'renders the subject' do
      expect(mail.subject).to eq(subject)
    end

    it 'renders the receiver email' do
      expect(mail.bcc).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['kamasi.washington@gmail.com'])
    end

    it 'assigns body' do
      expect(mail.body.encoded).to match(body)
    end
  end
end
