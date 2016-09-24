class RemoveRecipientAddress < ActiveRecord::Migration
  def change
    remove_column :recipients, :email    
    remove_column :recipients, :street   
    remove_column :recipients, :city     
    remove_column :recipients, :state    
    remove_column :recipients, :zip_code 
  end
end
