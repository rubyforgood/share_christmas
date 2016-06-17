class CreateVolunteerCenters < ActiveRecord::Migration
  def change
    create_table :volunteer_centers do |t|
      t.string :name
      t.string :location

      t.timestamps null: false
    end
  end
end
