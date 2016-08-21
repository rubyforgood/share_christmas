# == Schema Information
#
# Table name: organizations
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  url               :string
#  slug              :string
#

class Organization < ActiveRecord::Base
  # Use rolify to enforce org admin rights to particular users
  resourcify

  has_many :organization_campaigns
  has_many :campaigns, through: :organization_campaigns

  has_many :memberships
  has_many :users, through: :memberships

  has_attached_file :logo,
                    styles: {
                      medium: '300x300>',
                      thumb: '100x100>'
                    },
                    default_url: '/images/:style/missing.png'

  validates_attachment_content_type :logo, content_type: %r{\Aimage\/.*\Z}

  extend FriendlyId
  friendly_id :name, use: :slugged

  # TODO: String based SQL is not portable - make this nicer
  def joinable_campaigns
    Campaign.currently_running.where(
      "NOT EXISTS (
        SELECT 'X'
          FROM organization_campaigns oc
          WHERE oc.campaign_id = campaigns.id
                AND oc.organization_id = ?
      )", id
    )
  end

  # If there are overlapping campaigns, returns the one furthest out.
  def current_campaign
    return nil if campaigns.empty?
    campaigns.order(donation_deadline: 'DESC').first
  end

  def memberships_sorted_by_name
    memberships.includes(:user).order('users.last_name, users.first_name')
  end
end
