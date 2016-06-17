class VolunteerCenter < ActiveRecord::Base
  has_many :organizations
  has_many :campaigns
end
