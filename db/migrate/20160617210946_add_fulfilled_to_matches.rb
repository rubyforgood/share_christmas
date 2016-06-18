class AddFulfilledToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :fulfilled, :boolean, default: false
  end
end
