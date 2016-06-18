ActiveAdmin.register Organization do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :volunteer_center_id, :description, :logo
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :volunteer_center, hint: 'Volunteer Center to which the Organization is assigned'
      f.input :name, hint: 'Name of the organization'
      f.input :description
      f.input :logo, :as => :file, :hint => f.object.logo? ? image_tag(f.object.logo.url(:medium)) : content_tag(:span, 'Upload a PNG')
    end

    f.actions
  end

  show do |organization|
    attributes_table do
      row :volunteer_center
      row :name
      row :description
      row :logo do
        image_tag(organization.logo.url(:medium))
      end
      row :created_at
      row :updated_at
      # Will display the image on show object page
    end
  end
end
