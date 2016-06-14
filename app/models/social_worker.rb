# == Schema Information
#
# Table name: social_workers
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  email      :string(200)
#  phone      :string(20)
#  active     :boolean          default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#

class SocialWorker < ActiveRecord::Base
  has_many :recipient_families
end
