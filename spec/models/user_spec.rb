# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:u) { FactoryGirl.create :user }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(u).to be_valid
    end
  end

  describe 'Instance Methods >' do
    describe 'name >' do
      it 'smooshes first and last name' do
        expect(u.name).to eq 'Kamasi Washington'
      end
    end
  end
end
