class RemoveMatch < ActiveRecord::Migration
  def change
    add_reference :recipients, :membership, index: true, foreign_key: true
    add_column :recipients, :fulfilled, :boolean, default: false

    drop_table :matches do |t|
      t.references :membership, index: true, foreign_key: true
      t.references :recipient, index: true, foreign_key: true
      t.boolean :fulfilled, default: false

      t.timestamps null: false
    end
  end
end
