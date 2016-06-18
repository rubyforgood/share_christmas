class AddRecipientFamilyToRecipients < ActiveRecord::Migration
  def change
    add_reference :recipients, :recipient_family, index: true, foreign_key: true
  end
end
