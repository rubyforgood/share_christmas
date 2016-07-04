# == Schema Information
#
# Table name: campaigns
#
#  id                  :integer          not null, primary key
#  volunteer_center_id :integer
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  donation_deadline   :date
#  reminder_date       :date
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#

FactoryGirl.define do
  factory(:campaign) do
    volunteer_center
    name 'MyString'
    description 'MyString'
    donation_dateline Date.today + 7
    reminder_date Date.today + 14
    logo { fixture_file_upload(Rails.root.join('public', 'images', 'original', 'missing.png')) }
  end
end
