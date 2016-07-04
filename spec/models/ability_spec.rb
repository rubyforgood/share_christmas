require "spec_helper"

describe Ability do
  let (:u) { create(:user) }
  let (:org) { create(:organization) }

  context "Constructors >" do
    it "allows a user with no roles to only read stuff" do
      ab = Ability.new(u)
      expect(ab.cannot?(:manage, :all))
      expect(ab.cannot?(:manage, org))
      expect(ab.can?(:read, :all))
    end

    it "allows a user with volunteer center admin role to manage everything" do
      vca = create(:volunteer_center_admin)
      ab = Ability.new(vca)
      expect(ab.can?(:manage, :all))
    end

    it "allows a member with org admin role to manage organization" do
      moa = create(:membership_org_admin)
      ab = Ability.new(moa.user)
      expect(ab.cannot?(:manage, :all))
      expect(ab.can?(:manage, org))
    end

  end
end