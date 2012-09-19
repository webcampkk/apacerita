ActiveAdmin.register Event do
  menu priority: 1  

  index do
    column "Category" do |event|
      status_tag(event.category.name, :ok)
    end
    column :name
    column "Date/Time" do |event|
      event.date_and_time
    end
    column :venue
    default_actions
  end

  form do |f|
    f.inputs "Basic Information" do
      f.input :name
      f.input :venue, :hint => "A short description for location of event. "
      f.input :start_date
      f.input :end_date
      f.input :start_time, :as => :time
      f.input :end_time, :as => :time
      f.input :description
    end

    f.inputs "Location information" do
      f.input :longitude
      f.input :latitude
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

end
