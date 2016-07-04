# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  user_id         :integer
#  send_email      :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  org_admin       :boolean
#

FactoryGirl.define do
  factory :membership do
    organization
    user
    send_email false
    org_admin false

    factory :membership_org_admin do
      association :user, factory: :user_org_admin
      org_admin true
    end
    
  end
end
