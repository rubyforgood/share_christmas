# Note this is not persisted to the database.

class Appeal
  include ActiveModel::Model

  attr_accessor :organization_campaign_id, :subject, :content

  def organization_campaign
    OrganizationCampaign.find(@organization_campaign_id)
  end

  def organization
    organization_campaign.organization
  end

  def send(from_user)
    user_emails = organization.memberships_with_email.map(&:user_email)
    MembershipMailer.organization_campaign_email(
      from_user, user_emails, @subject, @content
    ).deliver_now
  end
end
