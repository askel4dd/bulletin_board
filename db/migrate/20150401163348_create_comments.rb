class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.timestamps null: false
    end
      add_reference :comments, :user, index: true
      add_reference :comments, :advert, index: true

      add_foreign_key :comments, :users
      add_foreign_key :comments, :adverts
  end
end
