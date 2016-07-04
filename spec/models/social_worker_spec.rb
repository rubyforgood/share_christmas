# == Schema Information
#
# Table name: social_workers
#
#  id              :integer          not null, primary key
#  assigned_number :integer
#  last_name       :string
#  first_name      :string
#  email           :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe SocialWorker, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
