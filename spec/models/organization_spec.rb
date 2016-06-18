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

require 'rails_helper'

describe Organization do
  # it 'tests the truth' do
  #   expect(true).to be true
  # end
end
