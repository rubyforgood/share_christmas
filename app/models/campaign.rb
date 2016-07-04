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

  scope :joined_by, ->(org_id) { 
    joins(:organization_campaigns).
    where(organization_campaigns: {organization_id: org_id}) 
  }

  # TODO: String based SQL is not portable - make this nicer
  scope :not_joined_by, ->(org_id) {
    Campaign.where(
      "NOT EXISTS (
        SELECT 'X' 
          FROM organization_campaigns oc 
          WHERE oc.campaign_id = campaigns.id
                AND oc.organization_id = ?
      )", org_id
    )
  }

  scope :currently_running, -> { where("campaigns.donation_deadline >= current_date") }

  scope :joinable_by, ->(org_id) { not_joined_by(org_id).currently_running }

  # If there are overlapping campaigns, returns the one furthest out.  
  def self.current_campaign_id(org_id)
    last_campaign = joined_by(org_id).order(donation_deadline: "DESC").first
    last_campaign ? last_campaign.id : -1
  end

end
