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

require 'rails_helper'

RSpec.describe Membership, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
