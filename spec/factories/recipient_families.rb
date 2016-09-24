# == Schema Information
#
# Table name: recipient_families
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  social_worker_id         :integer
#  casenumber               :integer
#  contact_last_name        :string
#  contact_first_name       :string
#  address                  :string
#  city                     :string
#  state                    :string
#  zip                      :string
#  phone                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  campaign_id              :integer
#

FactoryGirl.define do
  factory :recipient_family do
    organization_campaign
    contact_last_name 'Wallace'
    contact_first_name 'John'
  end
end
