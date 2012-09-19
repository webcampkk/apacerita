class Event < ActiveRecord::Base

  attr_accessible :name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email, :category_id

  validates :name, :presence => true
  validates :venue, :presence => true
  validates :start_date, :presence => true
  validates :description, :presence => true

  belongs_to :category

  before_save :qualify_website_address, :set_date_for_time

  def date_and_time
    str = "#{start_date.strftime("%d %b %Y")}"
    str += " - #{end_date.strftime("%d %b %Y")}" unless end_date.blank?
    str += " #{start_time.strftime("%I:%M %p")}" unless start_time.blank?
    str += " #{end_time.strftime("%I:%M %p")}" unless end_time.blank?
    str
  end

  def time
    time_str = ""
    time_str += "#{start_time.strftime("%I:%M %p")}" unless start_time.blank?
    time_str += " - #{end_time.strftime("%I:%M %p")}" unless end_time.blank?
  end

  def location
    return venue unless venue.blank?
    return [latitude, longitude]
  end

protected
  def qualify_website_address
    return if website.blank?
    self.website = "http://#{website}" unless website.starts_with?("http://")
  end

  def set_date_for_time
    
  end

end
