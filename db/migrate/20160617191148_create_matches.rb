class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :donor, index: true, foreign_key: true
      t.references :recipient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
