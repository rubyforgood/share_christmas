class AddOrgAdminFlagToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :org_admin, :boolean
  end
end
