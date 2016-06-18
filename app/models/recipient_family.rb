# == Schema Information
#
# Table name: recipient_families
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  social_worker_id         :integer
#  casenumber               :integer
#  last_name                :string
#  first_name               :string
#  address                  :string
#  city                     :string
#  state                    :string
#  zip                      :string
#  phone                    :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class RecipientFamily < ActiveRecord::Base
  belongs_to :organization_campaign
  belongs_to :social_worker
end
