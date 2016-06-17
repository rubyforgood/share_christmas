class Match < ActiveRecord::Base
  belongs_to :donor
  belongs_to :recipient
end
