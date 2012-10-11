class Event < ActiveRecord::Base

  acts_as_gmappable :process_geocoding => :geocode_if_no_coordinates, 
                    :check_process => false, :validation => false

  attr_accessible :name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email, :category_id,
                  :submitter_name, :submitter_email, :submitter_website

  validates :name, :presence => true
  validates :venue, :presence => true
  validates :start_date, :presence => true
  validates :description, :presence => true

  belongs_to :category

  before_save :qualify_website_address
  after_initialize :set_default_values

  paginates_per 10

  state_machine :state, :initial => :new do
    event :approve do
      transition all => :approved
    end

    event :reject do
      transition all => :rejected
    end
  end

  scope :pending, where(:state => "new")
  scope :approved, where(:state => "approved")
  scope :rejected, where(:state => "rejected")
  scope :upcoming, lambda { |date = Date.today| 
    date ||= Date.today
    where(["start_date >= :date OR (start_date <= :date AND end_date >= :date)", { :date => date }]) 
  }
  scope :soon, order("start_date ASC")
  scope :search, lambda { |keyword|
    where(["name LIKE :query OR venue LIKE :query OR description LIKE :query", :query => "%#{keyword}%"])
  }
  scope :in_category, lambda { |category| 
    where(:category_id => category) unless category.blank?
  }

  def to_param
    "#{id}-#{name.parameterize}"
  end

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
    self.website = "http://#{website}" if !website.blank? and if !website.starts_with?("http://") and !website.starts_with?("https://")
    self.submitter_website = "http://#{submitter_website}" if !submitter_website.blank? and !submitter_website.starts_with?("http://") and !submitter_website.starts_with?("https://")
  end

  def set_default_values
    self.latitude = 5.981296120253001 if latitude.zero? or latitude.blank?
    self.longitude = 116.07473399734499 if longitude.zero? or longitude.blank?
    self.start_date ||= Date.today
  end

  def geocode_if_no_coordinates
    latitude.blank? or longitude.blank?
  end

end
