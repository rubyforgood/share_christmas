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

require 'rails_helper'

RSpec.describe Recipient, type: :model do
  let(:r) { FactoryGirl.create :recipient }

  describe 'Factories >' do
    it 'has a valid factory' do
      expect(r).to be_valid
    end
  end

  describe 'Instance Methods >' do
    describe 'name >' do
      it 'smooshes first and last name' do
        expect(r.name).to eq 'Wesley Wallace'
      end
    end

    describe 'is_matched? >' do
      context 'without matches >' do
        it 'should be false' do
          expect(r.is_matched?).to eq false
        end
      end

      context 'with matches >' do
        let(:r) { FactoryGirl.create :recipient, matches: [FactoryGirl.create(:match)] }

        it 'should be true' do
          expect(r.is_matched?).to eq true
        end
      end
    end
  end
end
