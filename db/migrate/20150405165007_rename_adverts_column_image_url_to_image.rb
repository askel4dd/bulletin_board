class RenameAdvertsColumnImageUrlToImage < ActiveRecord::Migration
  def change
    rename_column :adverts, :image_url, :image
  end
end
