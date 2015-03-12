class AddColumnToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, default: 0
    change_column :cat_rental_requests, :user_id, :integer, null: false

    add_index :cat_rental_requests, :user_id
  end
end
