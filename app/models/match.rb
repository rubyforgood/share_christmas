class Match < ActiveRecord::Base
  belongs_to :membership
  belongs_to :recipient
end
