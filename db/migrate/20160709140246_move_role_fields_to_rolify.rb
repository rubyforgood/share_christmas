class MoveRoleFieldsToRolify < ActiveRecord::Migration
  def change
    remove_column :users, :roles_mask
    remove_column :memberships, :org_admin
  end
end
