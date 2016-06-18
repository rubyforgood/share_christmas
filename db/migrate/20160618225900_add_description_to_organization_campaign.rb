class AddDescriptionToOrganizationCampaign < ActiveRecord::Migration
  def change
    add_column :organization_campaigns, :description, :text
    add_column :organization_campaigns, :reminder_date, :date
    add_column :organization_campaigns, :donation_deadline, :date
  end
end
