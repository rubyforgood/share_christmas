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
  let(:oc) { FactoryGirl.create :organization_campaign }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(oc).to be_valid
    end
  end

  describe 'Instance Methods >' do
    describe 'assigned >' do
      it 'returns 0 if no recipients are assigned' do
        expect(oc.assigned).to eq 0
      end

      it 'returns >0 if some recipient families with recipients are assigned' do
        # Need to do this to ensure recipient_family is linked to our org campaign
        rf = FactoryGirl.create :recipient_family, organization_campaign: oc
        FactoryGirl.create :recipient, recipient_family: rf
        expect(oc.assigned).to eq 1
      end
    end

    describe 'matched >' do
      it 'returns 0 if no recipients are matched' do
        expect(oc.matched).to eq 0
      end

      it 'returns >0 if some recipients are matched' do
        membership = FactoryGirl.create(:membership)
        rf = FactoryGirl.create :recipient_family, organization_campaign: oc
        FactoryGirl.create :recipient, recipient_family: rf, membership: membership
        expect(oc.matched).to eq 1
      end
    end

    describe 'matched_pct >' do
      it 'returns 0 if no recipients are matched' do
        expect(oc.matched_pct).to eq 0
      end

      it 'returns >0 if some recipients are matched' do
        membership = FactoryGirl.create(:membership)
        rf = FactoryGirl.create :recipient_family, organization_campaign: oc
        FactoryGirl.create :recipient, recipient_family: rf, membership: membership
        expect(oc.matched_pct).to eq 100
      end
    end
  end
end
