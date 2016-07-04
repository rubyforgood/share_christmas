# == Schema Information
#
# Table name: recipients
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  first_name               :string
#  last_name                :string
#  email                    :string
#  street                   :string
#  city                     :string
#  state                    :string
#  zip_code                 :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  age                      :integer
#  gender                   :string
#  race                     :string
#  size                     :string
#  wish_list                :string
#  recipient_family_id      :integer
#

FactoryGirl.define do
  factory :recipient do
    organization_campaign_id
    recipient_family
    first_name "Wesley"
    last_name "Wallace"
  end
end
