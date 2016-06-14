# == Schema Information
#
# Table name: campaigns
#
#  id         :integer          not null, primary key
#  holiday_id :integer          not null
#  name       :string(50)       not null
#  active     :boolean          default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#

class Campaign < ActiveRecord::Base
  belongs_to :holiday
  has_many :deadlines
end
