# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  user_id         :integer
#  send_email      :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
end
