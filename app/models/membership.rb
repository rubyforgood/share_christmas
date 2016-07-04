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
#  org_admin       :boolean
#

class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :matches

  delegate :name, to: :user, allow_nil: true
  delegate :email, to: :user, allow_nil: true
  delegate :created_at, to: :user, prefix: true, allow_nil: true
  delegate :last_sign_in_at, to: :user, allow_nil: true

end
