class CreateShippingProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_providers, id: :uuid do |t|
      t.belongs_to :region, null: false, foreign_key: {to_table: :shipping_regions}, type: :uuid
      t.string :name
      t.string :tax_id, index: {unique: true}
      t.string :address
      t.string :email
      t.string :contact_number

      t.timestamps
    end
  end
end
