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
  has_many :recipients

  validates :organization_id, presence: true
  validates :campaign_id, presence: true

  with_options to: :campaign, prefix: true, allow_nil: true do |d|
    d.delegate :name, :description, :logo
  end
  delegate :name, to: :organization, prefix: true, allow_nil: true

  def assigned
    recipients.count
  end

  def matched
    recipients.joins(:matches).count
  end

  def matched_pct
    if assigned != 0
      ((matched.to_f / assigned.to_f) * 100.0).to_i
    else
      0    # Yeah, yeah I know 0/0 = infinity, but whatever.
    end
  end
end
