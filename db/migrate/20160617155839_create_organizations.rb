class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.references :volunteer_center, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
