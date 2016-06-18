class ChangeNamesInRecipientFamilies < ActiveRecord::Migration
  def change
    rename_column :recipient_families, :first_name, :contact_first_name
    rename_column :recipient_families, :last_name, :contact_last_name
  end
end
