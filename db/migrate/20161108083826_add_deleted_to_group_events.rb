class AddDeletedToGroupEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :group_events, :deleted, :boolean, null: false, default: false
  end
end
