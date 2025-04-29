class AddSourceToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :source, :string, default: 'undefined'
  end
end
