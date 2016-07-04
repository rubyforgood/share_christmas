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
  let (:oc) { create(:organization_campaign) }

  describe "Factories >" do
    it "has a valid factory" do
      expect(oc).to be_valid
    end
  end

  
  describe "Instance Methods >" do
    describe "assigned >" do
      it "returns 0 if no recipients are assigned" do
        # The default org campaign has one recipient, so we create a separate one
        oc2 = create(:organization_campaign_no_recipients)
        expect(oc2.assigned).to eq 0
      end

      it "returns >0 if some recipients are assigned" do
        # I can't get Factory to work here - get Trait not recognized.  Bluggh.
        Recipient.create!(organization_campaign_id: oc.id)
        expect(oc.assigned).to eq 1
      end
    end

    describe "matched >" do
      it "returns 0 if no recipients are matched" do
        # The default org campaign has one recipient, so we create a separate one
        oc2 = create(:organization_campaign_no_recipients)
        expect(oc2.matched).to eq 0
      end

      it "returns >0 if some recipients are matched" do
        recip = Recipient.create!(organization_campaign_id: oc.id)
        m = Match.create!(recipient: recip)
        expect(oc.matched).to eq 1
      end
    end

    describe "matched_pct >" do
      it "returns 0 if no recipients are matched" do
        # The default org campaign has one recipient, so we create a separate one
        oc2 = create(:organization_campaign_no_recipients)
        expect(oc2.matched_pct).to eq 0
      end

      it "returns >0 if some recipients are matched" do
        recip = Recipient.create!(organization_campaign_id: oc.id)
        m = Match.create!(recipient: recip)
        expect(oc.matched_pct).to eq 100
      end
    end
  end

end
