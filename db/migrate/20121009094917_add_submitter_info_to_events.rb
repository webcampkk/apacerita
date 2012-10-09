class AddSubmitterInfoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :submitter_name, :string
    add_column :events, :submitter_website, :string
    add_column :events, :submitter_email, :string
  end
end
