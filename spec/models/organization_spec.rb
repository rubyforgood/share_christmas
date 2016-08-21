# == Schema Information
#
# Table name: organizations
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  url               :string
#  slug              :string
#

require 'rails_helper'

describe Organization do
  describe 'Scopes >' do
  end

  describe 'Instance Methods >' do
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

    describe 'memberships_with_email >' do
      # TODO: Currently we can't really test this because we can't create users without
      # an email address.  This will be fixed with Issue #143.
      it 'only returns membership records where the user has an email address' do
        m1 = FactoryGirl.create :membership
        user_without_email = User.create(
          first_name: 'Willy', last_name: 'Smith', email: 'wsmith@gmail.com',
          password: 'BLUGGGGH', password_confirmation: 'BLUGGGGH'
        )
        m2 = FactoryGirl.create :membership,
                                organization: m1.organization, user: user_without_email
        expect(m1.organization.memberships_with_email).to eq [m1, m2]
      end
    end
  end
end
