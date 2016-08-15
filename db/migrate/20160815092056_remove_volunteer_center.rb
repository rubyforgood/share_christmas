class RemoveVolunteerCenter < ActiveRecord::Migration
  def change
    remove_reference :organizations, :volunteer_center, index: true, foreign_key: true
    remove_reference :campaigns, :volunteer_center, index: true, foreign_key: true

    drop_table :volunteer_centers
  end
end
