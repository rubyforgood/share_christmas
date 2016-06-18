class CreateSocialWorkers < ActiveRecord::Migration
  def change
    create_table :social_workers do |t|
      t.integer :assigned_number
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :phone

      t.timestamps null: false
    end
  end
end
