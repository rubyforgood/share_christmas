# == Schema Information
#
# Table name: organization_campaigns
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  campaign_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class OrganizationCampaign < ActiveRecord::Base
  belongs_to :organization
  belongs_to :campaign
  has_many :recipients

  validates :organization_id, presence: true
  validates :campaign_id, presence: true

  delegate :name, to: :campaign, prefix: true, allow_nil: true
  delegate :description, to: :campaign, prefix: true, allow_nil: true
  delegate :logo, to: :campaign, prefix: true, allow_nil: true
  delegate :name, to: :organization, prefix: true, allow_nil: true
end
