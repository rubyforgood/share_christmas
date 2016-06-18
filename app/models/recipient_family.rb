class RecipientFamily < ActiveRecord::Base
  belongs_to :organization_campaign
  belongs_to :social_worker
end
