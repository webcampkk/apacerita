atom_feed do |feed|
  feed.title("Events All Around KK - ApaCerita.my")
  feed.updated(@events[0].created_at) if @events.length > 0

  @events.each do |event|
    feed.entry(event) do |entry|
      entry.title(event.name)
      entry.venue(event.venue)
      entry.date(event_date_range(event))
      entry.time(event.time)
      entry.content(event.description, :type => 'html')
      entry.url(event_url(event))
      entry.latitude(event.latitude)
      entry.longitude(event.longitude)
      entry.organizer(event.organizer)
      entry.contact_person(event.contact_person)
      entry.phone_number(event.phone_number)
      entry.fax_number(event.fax_number)
      entry.website(event.website)
      entry.email(event.email)
    end
  end
end