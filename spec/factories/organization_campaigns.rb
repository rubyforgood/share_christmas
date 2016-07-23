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

FactoryGirl.define do
  factory(:organization_campaign) do
    organization
    campaign
    description 'Share Your Christmas 2015 for United Way'
    reminder_date Date.today + 7
    donation_deadline Date.today + 14
  end
end
