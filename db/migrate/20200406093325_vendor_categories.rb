class VendorCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :vendors_categories, :id => false do |t|
      t.integer :vendor_id
      t.integer :category_id
    end
  end
end
