class IncreaseLengthOfCoordinatesInEvents < ActiveRecord::Migration
  def change
    change_column :events, :latitude, :decimal, :precision => 15, :scale => 10, :default => 0
    change_column :events, :longitude, :decimal, :precision => 15, :scale => 10, :default => 0
  end

end
