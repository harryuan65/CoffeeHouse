class CreateShippingMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_methods, id: :uuid do |t|
      t.belongs_to :provider, null: false, foreign_key: {to_table: :shipping_providers}, type: :uuid
      t.string :name
      t.float :fee

      t.timestamps
    end
  end
end
