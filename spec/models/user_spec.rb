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
#  roles_mask             :integer
#  first_name             :string
#  last_name              :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let (:u) { create(:user) }

  describe "Factories >" do
    it "has a valid factory" do
      expect(u).to be_valid
    end
  end

  describe "Instance Methods >" do
    describe "add_role >" do
      it "saves a role into empty bitmask" do
        expect(u.roles_mask).to eq 0
        u.add_role("volunteer_center_admin")
        expect(u.roles_mask).to eq 1
      end

      it "adds a role to an existing bitmask without disturbing it" do
        u.add_role("volunteer_center_admin")
        expect(u.roles_mask).to eq 1
        u.add_role("org_admin")
        expect(u.roles_mask).to eq 3
      end
    end

    describe "roles >" do
      it "returns empty list for empty bitmask" do
        expect(u.roles).to be_empty
      end

      it "returns list with first role for bitmask with bit 1 set" do
        u.roles_mask = 1
        expect(u.roles).to match_array [:volunteer_center_admin]
      end
    end

    describe "name >" do
      it "smooshes first and last name" do
        expect(u.name).to eq "Kamasi Washington"
      end
    end
  end

end
