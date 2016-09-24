# == Schema Information
#
# Table name: recipient_families
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  social_worker_id         :integer
#  casenumber               :integer
#  contact_last_name        :string
#  contact_first_name       :string
#  address                  :string
#  city                     :string
#  state                    :string
#  zip                      :string
#  phone                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  campaign_id              :integer
#

class RecipientFamily < ActiveRecord::Base
  belongs_to :social_worker

  # A recipient family always belongs to a campaign
  belongs_to :campaign

  # A recipient family belongs to an organization campaign when they 
  # are assigned by the volunteer center.  It should always be the case
  # that the linked campaign here should match te campaign in the 
  # organization_campaign.
  belongs_to :organization_campaign

  # The individual members of the family
  has_many :recipients
end
