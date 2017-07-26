class BrandsStores < ActiveRecord::Migration[5.1]
  def change
    create_table(:brands_stores) do |t|
      t.column(:store_id, :integer)
      t.column(:brand_id, :integer)
      t.column(:store_name, :string)
      t.column(:brand_name, :string)

      t.timestamps()
    end
  end
end
