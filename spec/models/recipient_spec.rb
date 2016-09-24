# == Schema Information
#
# Table name: recipients
#
#  id                  :integer          not null, primary key
#  first_name          :string
#  last_name           :string
#  email               :string
#  street              :string
#  city                :string
#  state               :string
#  zip_code            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  age                 :integer
#  gender              :string
#  race                :string
#  size                :string
#  wish_list           :string
#  recipient_family_id :integer
#  membership_id       :integer
#  fulfilled           :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  let(:r) { FactoryGirl.create :recipient }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(r).to be_valid
    end
  end
end
