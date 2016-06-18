class AddLogoToOrganizationsAndCampaigns < ActiveRecord::Migration
  def up
    remove_column :organizations, :logo_file_name, :string
    add_attachment :organizations, :logo
    add_attachment :campaigns, :logo
  end

  def down
    add_column :organizations, :logo_file_name, :string
    remove_attachment :organizations, :logo
    remove_attachment :campaigns, :logo
  end
end
