# == Schema Information
#
# Table name: campaigns
#
#  id                  :integer          not null, primary key
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
    name 'Share Your Christmas 2015'
    description 'Share Your Christmas Campaign 2015'
    donation_deadline Date.today + 7
    reminder_date Date.today + 14
    # logo { fixture_file_upload(Rails.root.join('public', 'images', 'original', 'missing.png')) }

    trait :thanksgiving do
      name 'Thanksgiving 2015'
      description 'Thanksgiving Campaing 2015'
      donation_deadline Date.today + 107
      reminder_date Date.today + 114
    end
  end
end
