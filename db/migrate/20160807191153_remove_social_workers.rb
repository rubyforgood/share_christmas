class RemoveSocialWorkers < ActiveRecord::Migration
  def change
    remove_reference :recipient_families, :social_worker

    drop_table :social_workers
  end
end
