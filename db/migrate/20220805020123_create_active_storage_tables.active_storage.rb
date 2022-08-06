# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    # Use Active Record's configured type for primary and foreign keys
    primary_key_type, foreign_key_type = primary_and_foreign_key_types
    date_time_support = {
      null: false
    }
    date_time_support[:precision] = 6 if connection.supports_datetime_with_precision?
    create_table :active_storage_blobs, id: primary_key_type do |t|
      t.string :key, null: false
      t.string :filename, null: false
      t.string :content_type
      t.text :metadata
      t.string :service_name, null: false
      t.bigint :byte_size, null: false
      t.string :checksum

      t.datetime :created_at, **date_time_support

      t.index [:key], unique: true
    end

    create_table :active_storage_attachments, id: primary_key_type do |t|
      t.string :name, null: false
      t.references :record, null: false, polymorphic: true, index: false, type: foreign_key_type
      t.references :blob, null: false, type: foreign_key_type

      t.datetime :created_at, **date_time_support

      t.index [:record_type, :record_id, :name, :blob_id], name: :index_active_storage_attachments_uniqueness, unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end

    create_table :active_storage_variant_records, id: primary_key_type do |t|
      t.belongs_to :blob, null: false, index: false, type: foreign_key_type
      t.string :variation_digest, null: false

      t.index [:blob_id, :variation_digest], name: :index_active_storage_variant_records_uniqueness, unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end

  private

  def primary_and_foreign_key_types
    config = Rails.configuration.generators
    setting = config.options[config.orm][:primary_key_type]
    primary_key_type = setting || :primary_key
    foreign_key_type = setting || :bigint
    [primary_key_type, foreign_key_type]
  end
end
