class AddDurationToGroupEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :group_events, :duration, :integer
  end
end
