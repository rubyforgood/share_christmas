class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.references :volunteer_center, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
