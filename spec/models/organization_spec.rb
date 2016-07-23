# == Schema Information
#
# Table name: organizations
#
#  id                  :integer          not null, primary key
#  volunteer_center_id :integer
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#  url                 :string
#  slug                :string
#

require 'rails_helper'

describe Organization do
  describe 'Scopes >' do
  end

  describe 'Class Methods >' do
    describe 'joinable_campaigns' do
      it 'returns campaigns the organization has no org_camp record for' do
        oc = FactoryGirl.create :organization_campaign
        c2 = FactoryGirl.create :campaign, :thanksgiving
        expect(oc.organization.joinable_campaigns.count).to eq 1
        expect(oc.organization.joinable_campaigns.first.id).to eq c2.id
      end
    end

    describe 'current_campaign >' do
      it 'returns nil if the organization has no campaigns' do
        org2 = FactoryGirl.create :organization
        expect(org2.current_campaign).to be_nil
      end

      it 'returns campaign id if the organization has active campaign' do
        oc = FactoryGirl.create :organization_campaign
        expect(oc.organization.current_campaign).to eq oc.campaign
      end
    end
  end
end
