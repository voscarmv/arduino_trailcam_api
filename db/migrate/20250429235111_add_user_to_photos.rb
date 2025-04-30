class AddUserToPhotos < ActiveRecord::Migration[8.0]
  def change
    add_reference :photos, :user, null: false, foreign_key: true
  end
end
