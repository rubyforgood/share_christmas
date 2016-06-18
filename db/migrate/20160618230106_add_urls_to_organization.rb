class AddUrlsToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :url, :string
  end
end
