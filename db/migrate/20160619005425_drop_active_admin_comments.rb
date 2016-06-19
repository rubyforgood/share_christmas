class DropActiveAdminComments < ActiveRecord::Migration
  def change
    def up
      drop_table :active_admin_comments
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end
end
