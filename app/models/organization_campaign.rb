class OrganizationCampaign < ActiveRecord::Base
  belongs_to :organization
  belongs_to :campaign
end
