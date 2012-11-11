namespace :app do
  namespace :event do 
    desc "Set End Date to be Start Date if null"
    task :set_end_date => :environment do
      Event.find_each do |e|
        e.update_attributes :end_date => e[:start_date] if e.end_date.blank?
      end
    end
  end
end
