class AddDetailsToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :description, :string
    add_column :campaigns, :donation_deadline, :date
    add_column :campaigns, :reminder_date, :date
  end
end
