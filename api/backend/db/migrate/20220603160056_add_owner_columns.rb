class AddOwnerColumns < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums, :user, index: true
    rename_column :albums, :user_id, :owner_id
    add_reference :pictures, :user, index: true
    rename_column :pictures, :user_id, :owner_id
  end
end
