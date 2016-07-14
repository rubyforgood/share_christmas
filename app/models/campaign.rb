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

class Campaign < ActiveRecord::Base
  belongs_to :volunteer_center
  has_many :organization_campaigns

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  scope :currently_running, -> { where("campaigns.donation_deadline >= current_date") }
end
