# == Schema Information
#
# Table name: organization_campaigns
#
#  id                :integer          not null, primary key
#  organization_id   :integer
#  campaign_id       :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  reminder_date     :date
#  donation_deadline :date
#

class OrganizationCampaign < ActiveRecord::Base
  belongs_to :organization
  belongs_to :campaign
  has_many :recipient_families

  validates :organization_id, presence: true
  validates :campaign_id, presence: true

  with_options to: :campaign, prefix: true, allow_nil: true do |d|
    d.delegate :name, :description, :logo
  end
  delegate :name, to: :organization, prefix: true, allow_nil: true

  def recipients
    # There's probably a better way to do this
    Recipient.
      includes(:recipient_family).
      where(recipient_families: {organization_campaign_id: id})
  end

  def assigned
    # There's probably a slicker way to do this
    recipient_families.joins(:recipients).count
  end

  def matched
    # It'd be nice if you could use the references from recipient_famiies to 
    # recipients, but I couldn't find a way.
    recipient_families.joins(:recipients).where("recipients.membership_id IS NOT NULL").count
  end

  def matched_pct
    return 0 if assigned.zero? # Yeah, yeah I know 0/0 = infinity, but whatever.

    ((matched.to_f / assigned.to_f) * 100.0).to_i
  end
end
