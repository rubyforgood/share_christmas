# == Schema Information
#
# Table name: recipients
#
#  id                  :integer          not null, primary key
#  recipient_family_id :integer          not null
#  match_id            :integer
#  first_name          :string(60)       not null
#  age                 :decimal(5, 2)
#  gender              :string(1)
#  race                :string(1)
#  size                :string
#  need                :string(1000)
#  bike                :boolean          default(FALSE), not null
#  created_at          :datetime
#  updated_at          :datetime
#

class Recipient < ActiveRecord::Base
    belongs_to :recipient_family
    has_one :match
end
