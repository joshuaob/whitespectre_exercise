class AddStatusToGroupEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :group_events, :status, :string, null: false, default: "draft"
  end
end
