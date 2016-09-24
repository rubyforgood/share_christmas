# Preview all emails at http://localhost:3000/rails/mailers/membership_mailer
class MembershipMailerPreview < ActionMailer::Preview
  def organization_campaign_email
    MembershipMailer.organization_campaign_email(
      User.first,
      OrganizationCampaign.first,
      'Test Subject', 'Hi!'
    )
  end
end
