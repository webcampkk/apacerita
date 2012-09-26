class Event < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => :geocode_if_no_coordinates, 
                    :check_process => false, :validation => false

  attr_accessible :name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email, :category_id

  validates :name, :presence => true
  validates :venue, :presence => true
  validates :start_date, :presence => true
  validates :description, :presence => true

  belongs_to :category

  before_save :qualify_website_address, :set_date_for_time

  paginates_per 10

  scope :upcoming, lambda { |date = Date.today| 
    date ||= Date.today
    where(["start_date >= ?", date]) 
  }
  scope :soon, order("start_date ASC")
  scope :search, lambda { |keyword|
    where(["name LIKE :query OR venue LIKE :query OR description LIKE :query", :query => "%#{keyword}%"])
  }

  def time
    time_str = ""
    unless start_time.blank?
      time_str += "#{start_date.strftime("%e %b")} - " if start_date != end_date and !end_date.blank?
      time_str += "#{start_time.strftime("%I:%M %p")}" 
    end
    unless end_time.blank?
      time_str += " \u2014"
      time_str += " #{end_date.strftime("%e %b")} -" if start_date != end_date and !end_date.blank?
      time_str += " #{end_time.strftime("%I:%M %p")}" 
    end
  end

  def location
    return [latitude, longitude] unless latitude.blank?
    full_address
  end

  def gmaps4rails_address
    full_address
  end

  def full_address
    "#{venue}, Kota Kinabalu, Sabah, Malaysia"
  end

protected
  def qualify_website_address
    return if website.blank?
    self.website = "http://#{website}" unless website.starts_with?("http://")
  end

  def set_date_for_time
    
  end

  def geocode_if_no_coordinates
    latitude.blank? or longitude.blank?
  end

end
