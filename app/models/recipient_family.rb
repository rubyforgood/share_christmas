# == Schema Information
#
# Table name: recipient_families
#
#  id               :integer          not null, primary key
#  campaign_id      :integer          not null
#  organization_id  :integer
#  social_worker_id :integer          not null
#  casenumber       :integer
#  last_name        :string(40)       not null
#  first_name       :string(40)
#  address          :string(200)
#  city             :string(50)
#  state            :string(2)        default("NC")
#  zip              :string(10)
#  phone            :string(100)
#  profile          :string(2000)
#  deliverable      :boolean          default(TRUE), not null
#  latlng           :string(60)
#  created_at       :datetime
#  updated_at       :datetime
#

class RecipientFamily < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :organization
  belongs_to :social_worker
  has_many :recipients
 
end
