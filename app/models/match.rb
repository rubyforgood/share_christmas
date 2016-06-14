# == Schema Information
#
# Table name: matches
#
#  id           :integer          not null, primary key
#  giver_id     :integer          not null
#  recipient_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Match < ActiveRecord::Base
  belongs_to :giver
  belongs_to :recipient
end
