# == Schema Information
#
# Table name: organizations
#
#  id                  :integer          not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#  url                 :string
#  slug                :string
#

FactoryGirl.define do
  factory(:organization) do
    name 'United Way'
    description 'United Way of Durham'
    # logo { fixture_file_upload(Rails.root.join('public', 'images', 'original', 'missing.png')) }
    url 'http://unitedwaydurham.org'
  end
end
