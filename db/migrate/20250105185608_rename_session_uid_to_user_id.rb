class RenameSessionUidToUserId < ActiveRecord::Migration[8.0]
  def change
    rename_column :orders, :session_uid, :user_id
  end
end
