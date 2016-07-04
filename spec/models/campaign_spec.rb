# == Schema Information
#
# Table name: campaigns
#
#  id                  :integer          not null, primary key
#  volunteer_center_id :integer
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  donation_deadline   :date
#  reminder_date       :date
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#

require 'rails_helper'

describe Campaign do
  let (:c) { create(:campaign) }

  describe "Factories >" do
    it "has a valid factory" do
      expect(c).to be_valid
    end
  end

  describe "Scopes >" do
    describe "not_joined_by" do
      it "returns campaigns the organization has no org_camp record for" do
        oc = create(:organization_campaign)
        c2 = create(:campaign_thanksgiving)
        expect(Campaign.not_joined_by(oc.organization_id).count).to eq 1
        expect(Campaign.not_joined_by(oc.organization_id).first.id).to eq c2.id
      end
    end
  end

  describe "Class Methods >" do
    describe "current_campaign_id >" do
      it "returns -1 if the organization has no campaigns" do
        org = create(:organization_lazy)
        expect(Campaign.current_campaign_id(org.id) == -1)
      end

      it "returns campaign id if the organization has active campaign" do
        oc = create(:organization_campaign)
        expect(Campaign.current_campaign_id(oc.organization_id) == c.id)
      end
    end
  end
end
