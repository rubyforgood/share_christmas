class CreateRecipientFamilies < ActiveRecord::Migration
  def change
    create_table :recipient_families do |t|
      t.references :organization_campaign, index: true, foreign_key: true
      t.references :social_worker, index: true, foreign_key: true
      t.integer :casenumber
      t.string :last_name
      t.string :first_name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone

      t.timestamps null: false
    end
  end
end
