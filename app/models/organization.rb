# == Schema Information
#
# Table name: organizations
#
#  id                  :integer          not null, primary key
#  volunteer_center_id :integer
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  description         :text
#  url                 :string
#  logo_file_name      :string
#  logo_content_type   :string
#  logo_file_size      :integer
#  logo_updated_at     :datetime
#

class Organization < ActiveRecord::Base
  belongs_to :volunteer_center

  has_many :organization_campaigns
  has_many :campaigns, through: :organization_campaigns

  has_many :memberships
  has_many :users, through: :memberships

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
