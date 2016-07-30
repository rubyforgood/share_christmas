require 'concerns/form_helpers'

ActiveAdmin.register Campaign do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :volunteer_center_id, :description, :donation_deadline,
                :reminder_date, :logo
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Details' do
      f.input :volunteer_center
      f.input :name
      f.input :description
      f.input :donation_deadline
      f.input :reminder_date
      f.input :logo, as: :file, hint: FormHelpers.file_hint(f)
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :created_at
    column :name
    column :volunteer_center
    column :donation_deadline
    column :reminder_date
    html_column :description
    image_column :logo
    actions
  end

  show do |_organization|
    attributes_table do
      row :id
      row :volunteer_center
      row :name
      row :created_at
      row :updated_at
      html_row :description
      row :donation_deadline
      row :reminder_date
      image_row :logo
    end
  end
end
