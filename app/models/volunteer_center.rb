# == Schema Information
#
# Table name: volunteer_centers
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class VolunteerCenter < ActiveRecord::Base
  has_many :organizations
  has_many :campaigns
end
