# == Schema Information
#
# Table name: recipients
#
#  id                       :integer          not null, primary key
#  organization_campaign_id :integer
#  first_name               :string
#  last_name                :string
#  email                    :string
#  street                   :string
#  city                     :string
#  state                    :string
#  zip_code                 :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  age                      :integer
#  gender                   :string
#  race                     :string
#  size                     :string
#  wish_list                :string
#  recipient_family_id      :integer
#

class Recipient < ActiveRecord::Base
  belongs_to :organization_campaign
  belongs_to :recipient_family
  belongs_to :membership

  scope :matched, -> { where.not(membership_id: nil) }

  def name 
    "#{first_name} #{last_name}"
  end

  # Race and size are only listed where relevant, for dolls and clothes respectively
  def other_details
    [ race.blank? ? nil : "Race: #{race}",
      size.blank? ? nil : "Size: #{size}"
    ].compact.join(", ")
  end

  def matched?
    ! membership_id.nil?
  end
end
