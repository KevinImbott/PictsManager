class RefactoDescriptionToTagsForPictures < ActiveRecord::Migration[7.0]
  def change
    remove_column :pictures, :description
    add_column :pictures, :tags, :string, array: true, default: []
  end
end
