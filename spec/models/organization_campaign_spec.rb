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

require 'rails_helper'

describe OrganizationCampaign do
  # it 'tests the truth' do
  #   expect(true).to be true
  # end
end
