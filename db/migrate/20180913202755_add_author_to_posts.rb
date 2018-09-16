class AddAuthorToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :author_id, :int
  end
end
