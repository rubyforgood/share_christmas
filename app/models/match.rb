# == Schema Information
#
# Table name: matches
#
#  id            :integer          not null, primary key
#  recipient_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  fulfilled     :boolean          default(FALSE)
#  membership_id :integer
#

class Match < ActiveRecord::Base
  belongs_to :membership
  belongs_to :recipient
end
