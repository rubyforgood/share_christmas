# == Schema Information
#
# Table name: organizations
#
#  id           :integer          not null, primary key
#  name         :string(100)      not null
#  key          :string(50)
#  email_from   :string(100)
#  image_uid    :string(500)
#  image_name   :string(100)
#  active       :boolean          default(TRUE), not null
#  instructions :text
#  about        :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Organization < ActiveRecord::Base

end
