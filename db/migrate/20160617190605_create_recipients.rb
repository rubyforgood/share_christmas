class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.references :organization_campaign, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps null: false
    end
  end
end
