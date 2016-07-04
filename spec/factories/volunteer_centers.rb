# == Schema Information
#
# Table name: volunteer_centers
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory(:volunteer_center) do
    name 'MyString'
    location 'MyString'
  end
end
