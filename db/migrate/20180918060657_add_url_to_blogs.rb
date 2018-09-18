class AddUrlToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :url, :text
  end
end
