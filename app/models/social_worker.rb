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

class SocialWorker < ActiveRecord::Base
end
