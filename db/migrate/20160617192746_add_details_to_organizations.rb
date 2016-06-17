class AddDetailsToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :description, :text
    add_column :organizations, :logo_file_name, :string
    add_column :organizations, :url, :string
  end
end
