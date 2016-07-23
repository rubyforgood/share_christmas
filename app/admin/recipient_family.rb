ActiveAdmin.register RecipientFamily do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :organization_campaign_id, :casenumber, :social_worker_id, :contact_first_name, :contact_last_name, :address, :city, :state, :zip, :phone
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
