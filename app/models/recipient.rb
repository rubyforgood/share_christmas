class Recipient < ActiveRecord::Base
  belongs_to :organization_campaign
  has_many :matches
  has_many :donors, through: :matches
end
