class Donor < ActiveRecord::Base
  belongs_to :organization_campaign
  has_many :matches
  has_many :recipients, through: :matches
end
