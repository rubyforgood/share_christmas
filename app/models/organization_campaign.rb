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
end
