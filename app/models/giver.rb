# == Schema Information
#
# Table name: givers
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  email      :string(200)      not null
#  phone      :string(20)
#  created_at :datetime
#  updated_at :datetime
#

class Giver < ActiveRecord::Base
  has_many :matches
end
