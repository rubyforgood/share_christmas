class AddCampaignLinkToRecipientFamily < ActiveRecord::Migration
  def change
    add_reference :recipient_families, :campaign, index: true, foreign_key: true
    remove_reference :recipients, :organization_campaign
  end
end
