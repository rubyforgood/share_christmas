class RemoveDonors < ActiveRecord::Migration
  def change
    remove_reference :matches, :donor
    add_reference :matches, :membership, index: true, foreign_key: true

    drop_table :donors
  end
end
