class AddUnicityToUsersPseudo < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :pseudo, unique: true
  end
end
