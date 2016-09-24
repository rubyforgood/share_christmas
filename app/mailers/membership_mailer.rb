class MembershipMailer < ApplicationMailer
  def organization_campaign_email(from, user_emails, subject, content)
    @content = content
    mail(from: from.email, to: from.email, bcc: user_emails, subject: subject)
  end
end
