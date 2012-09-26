class AddStateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :state, :string, :default => "new"
  end
end
