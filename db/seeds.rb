# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Product.create!(
  name: "黃金曼特寧 - 濾掛包 20 包",
  sku: "bean_mandheling_01",
  price: 300,
  available_count: 3
)
