module ApplicationHelper

  def event_date_range(event)
    date_range = ""
    if event.start_date == event.end_date or event.end_date.blank?
      date_range = "#{event.start_date.strftime("%d %B %Y")}"
    elsif event.start_date.month == event.end_date.month && event.start_date.year == event.end_date.year
      date_range = "#{event.start_date.strftime("%d")} - #{event.end_date.strftime("%d %b %Y")}"
    else
      date_range = "#{event.start_date.strftime("%d %b")} - #{event.end_date.strftime("%d %b %Y")}"
    end  
  end

  def static_google_map_image(options = {})
    options.reverse_merge!({ size: "250x200", scale: 1, sensor: false, zoom: 17 })
    location = options.delete(:location)
    location = location.join(",") if location.is_a?(Array)
    url = "http://maps.googleapis.com/maps/api/staticmap?center=#{location}"
    options.each { |k,v| url += "&#{k}=#{v}" }
    url += "&markers=size:medium%7Ccolor:green%7C#{location}"
    image_tag(url)
  end

end
