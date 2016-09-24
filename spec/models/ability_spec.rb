require 'spec_helper'

describe Ability do
  let(:u) { FactoryGirl.create :user }
  let(:org) { FactoryGirl.create :organization }

  context 'Constructors >' do
    it 'allows a user with no roles to only read stuff' do
      ab = Ability.new(u)

      expect(ab.cannot?(:manage, Campaign))
      expect(ab.cannot?(:manage, org))
    end

    it 'allows a user with global admin role to manage everything' do
      u.add_role :admin
      ab = Ability.new(u)

      expect(ab.can?(:manage, :all))
    end

    it 'allows a member with org admin role to manage organization' do
      u.add_role(:admin, org)
      ab = Ability.new(u)

      expect(ab.cannot?(:manage, Campaign))
      expect(ab.can?(:manage, org))
    end
  end
end
