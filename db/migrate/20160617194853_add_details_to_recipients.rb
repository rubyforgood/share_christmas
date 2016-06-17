class AddDetailsToRecipients < ActiveRecord::Migration
  def change
    add_column :recipients, :age, :integer
    add_column :recipients, :gender, :string
    add_column :recipients, :race, :string
    add_column :recipients, :size, :string
    add_column :recipients, :wish_list, :string
  end
end
