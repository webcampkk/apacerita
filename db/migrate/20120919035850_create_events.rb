class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :category
      t.string :name
      t.string :venue
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.float :longitude
      t.float :latitude
      t.text :description
      t.string :organizer
      t.string :contact_person
      t.string :phone_number
      t.string :fax_number
      t.string :website
      t.string :email
      t.timestamps
    end
  end
end
