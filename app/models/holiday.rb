# == Schema Information
#
# Table name: holidays
#
#  id         :integer          not null, primary key
#  name       :string(100)      not null
#  season     :string
#  about      :text
#  active     :boolean          default(TRUE), not null
#  created_at :datetime
#  updated_at :datetime
#

class Holiday < ActiveRecord::Base

end
