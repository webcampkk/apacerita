ActiveAdmin.register Event do
  menu priority: 1  

  index do
    column "Category" do |event|
      status_tag(event.category.name, :ok)
    end
    column :name
    column "Date/Time" do |event|
      "#{event.start_date.strftime("%e %b")} - #{event.time}"
    end
    column :venue
    default_actions
  end

  form do |f|
    f.inputs "Basic Information" do
      f.input :category
      f.input :name
      f.input :venue, :hint => "A short description for location of event. "
      f.input :start_date
      f.input :end_date
      f.input :start_time, :as => :time
      f.input :end_time, :as => :time
      f.input :description
    end

    f.inputs "Location information" do
      f.input :latitude
      f.input :longitude, :hint => render(:partial => "active_admin/shared/map", :locals => { :event => f.object, :editable => true })
    end

    f.inputs "Contact Information" do
      f.input :organizer
      f.input :contact_person
      f.input :phone_number
      f.input :fax_number
      f.input :website
      f.input :email
    end


    f.buttons
  end

  show do |event|
    attributes_table do
      row :name
      row :start_date
      row :end_date
      row :start_time
      row :end_time
      row :venue
      row :latitude
      row :longitude
      row "location" do |e|
        render :partial => "active_admin/shared/map", :locals => { :event => e }
      end
      row :description
      row :organizer
      row :contact_person
      row :phone_number
      row :fax_number
      row :website
      row :email
    end
    active_admin_comments
  end

end
