class RemoveUrlFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :url, :string
  end
end
