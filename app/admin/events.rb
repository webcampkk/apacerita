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
end
