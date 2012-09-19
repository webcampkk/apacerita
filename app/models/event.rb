class Event < ActiveRecord::Base
  
  attr_accessible :name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email

  validates :name, :presence => true
  validates :venue, :presence => true
  validates :start_date, :presence => true
  validates :description, :presence => true

end
