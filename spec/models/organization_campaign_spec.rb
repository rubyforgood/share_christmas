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
      context 'with no recipients assigned> ' do
        it 'returns 0' do
          expect(oc.assigned).to eq 0
        end
      end

      context 'with some recipients assigned' do
        let!(:rf) {FactoryGirl.create :recipient_family, organization_campaign: oc}
        let!(:recipient) { FactoryGirl.create :recipient, recipient_family: rf }

        it 'returns >0 if some recipients are assigned' do
          expect(oc.assigned).to eq 1
        end
      end
    end

    describe 'matched >' do
      context 'with no recipients matched' do
        it 'returns 0' do
          expect(oc.matched).to eq 0
        end
      end

      context 'with some recipients matched' do
        let!(:membership) { FactoryGirl.create :membership  }
        let!(:rf) {FactoryGirl.create :recipient_family, organization_campaign: oc}
        let!(:recipient) { FactoryGirl.create :recipient, recipient_family: rf, organization_campaign: oc, membership: membership }

        it 'returns >0' do
          expect(oc.matched).to eq 1
        end
      end
    end

    describe 'matched_pct >' do
      context 'with no recipients matched' do
        it 'returns 0' do
          expect(oc.matched_pct).to eq 0
        end
      end

      context 'with some recipients matched' do
        let!(:membership) { FactoryGirl.create :membership  }
        let!(:rf) {FactoryGirl.create :recipient_family, organization_campaign: oc}
        let!(:recipient) { FactoryGirl.create :recipient, recipient_family: rf, organization_campaign: oc, membership: membership }

        it 'returns >0 if some recipients are matched' do
          expect(oc.matched_pct).to eq 100
        end
      end
    end
  end
end
