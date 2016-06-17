class Organization < ActiveRecord::Base
  belongs_to :volunteer_center

  has_many :organization_campaigns
end
