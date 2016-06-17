class CreateOrganizationCampaigns < ActiveRecord::Migration
  def change
    create_table :organization_campaigns do |t|
      t.references :organization, index: true, foreign_key: true
      t.references :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
