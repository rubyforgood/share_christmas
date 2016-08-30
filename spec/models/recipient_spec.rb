# == Schema Information
#
# Table name: recipients
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  first_name               :string
#  last_name                :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  age                      :integer
#  gender                   :string
#  race                     :string
#  size                     :string
#  wish_list                :string
#  recipient_family_id      :integer
#  membership_id            :integer
#  fulfilled                :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  let(:org) { FactoryGirl.create :organization, name: 'Company' }
  let(:oc) { FactoryGirl.create :organization_campaign, organization: org }
  let(:r) { FactoryGirl.create :recipient, organization_campaign: oc }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(r).to be_valid
    end
  end

  describe 'Instance Methods >' do
    describe 'name' do
      it 'returns full name' do
        expect(r.name).to eq 'Wesley Wallace'
      end
    end

    describe 'other_details' do
      it 'returns blank string if neither race nor size is recorded' do
        expect(r.other_details).to eq ''
      end

      it 'returns Race if race is recorded' do
        r2 = FactoryGirl.build(:recipient, race: 'African-American', organization_campaign: oc)
        expect(r2.other_details).to eq 'Race: African-American'
      end

      it 'returns Race and size if both are recorded' do
        r2 = FactoryGirl.build(:recipient,
                               race: 'African-American',
                               size: 4,
                               organization_campaign: oc)

        expect(r2.other_details).to eq 'Race: African-American, Size: 4'
      end
    end

    describe 'matched?' do
      it 'returns false if no membership filled in' do
        expect(r).to_not be_matched
      end

      it 'returns true if membership filled in' do
        r.membership_id = 666
        expect(r).to be_matched
      end
    end
  end
end
