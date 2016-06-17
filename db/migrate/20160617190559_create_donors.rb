class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.references :organization_campaign, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
