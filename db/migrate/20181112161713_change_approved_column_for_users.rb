class ChangeApprovedColumnForUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :approved
    add_column :users, :need_admin_approval, :boolean, default: :false
  end
end
