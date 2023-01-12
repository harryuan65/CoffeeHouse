class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments, id: :uuid do |t|
      t.references :shipping_method, null: false, type: :uuid
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.string :email
      t.string :city
      t.string :address
      t.string :status
      t.datetime :started_at

      t.timestamps
    end
  end
end
