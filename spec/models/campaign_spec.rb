# == Schema Information
#
# Table name: campaigns
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  description       :text
#  donation_deadline :date
#  reminder_date     :date
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#

require 'rails_helper'

describe Campaign do
  let(:c) { FactoryGirl.create :campaign }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(c).to be_valid
    end
  end
end
