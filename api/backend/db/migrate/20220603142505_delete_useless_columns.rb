class DeleteUselessColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :picture_id, :bigint
    remove_column :albums, :user_id, :bigint
    remove_column :pictures, :url, :string
  end
end
