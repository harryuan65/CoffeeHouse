# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

product = Product.create!(
  name: "黃金曼特寧 - 濾掛包 20 包",
  sku: "bean_mandheling_01",
  price: 300,
  available_count: 3
)

admin = User.new(
  email: ENV["ADMIN_EMAIL"] || "admin@gmail.com"
)

admin.password = "111111"
admin.save

product.content.update!(body: ActionText::Content.new("<h1>★黃金曼特寧</h1><div><br></div><div>黃金曼特寧泛指蘇門達臘產區精緻栽培與加工的曼特寧，從萌芽生長、開花結果到生豆處理、烘培研磨及沖煮品嚐，每一個環節都影響咖啡豆的風味。在製程上，完全手工摘取，經過半水洗日晒乾燥後，再經四次人工篩選。</div><div><br></div><div>古典獨特的強烈口感與香氣，帶有濃郁的醇度和馥鬱而活潑的動感卻不酸澀，醇度、苦度可以表露無遺，品質堪稱世界之最，一度被專家認為是世界上最好的咖啡。</div><div><br></div><div>它有濃厚的口感以及像酒一般的醇度，並帶有濃烈野香，風味低沈老練，只有一點點酸性，餘韻深入喉嚨久久不去。</div>"))
