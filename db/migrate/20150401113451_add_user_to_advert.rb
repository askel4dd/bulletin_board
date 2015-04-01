class AddUserToAdvert < ActiveRecord::Migration
  def change
    add_reference :adverts, :user, index: true
    add_foreign_key :adverts, :users
  end
end
