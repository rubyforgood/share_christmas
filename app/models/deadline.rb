# == Schema Information
#
# Table name: deadlines
#
#  id            :integer          not null, primary key
#  campaign_id   :integer          not null
#  name          :string(60)       not null
#  due_date      :date             not null
#  due_time      :time
#  reminder_date :date
#  description   :string(100)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Deadline < ActiveRecord::Base
  belongs_to :campaign
end
