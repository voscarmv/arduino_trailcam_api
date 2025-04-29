class AddViewedToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_column :photos, :viewed, :boolean, default: false, null: false
  end
end
