# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

product1 = Product.create!(
  name: "黃金曼特寧 - 濾掛包 20 包",
  sku: "bean_mandheling_01",
  price: 300,
  category: :consumable,
  available_count: 3
)

product2 = Product.create!(
  name: "名字比較長一點的黃金曼特寧 - 濾掛包 40 包",
  sku: "bean_mandheling_02",
  price: 550,
  category: :consumable,
  available_count: 7
)

product3 = Product.create!(
  name: "哇靠名字有夠長欸怎麼辦要換行欸的黃金曼特寧 - 濾掛包 60 包",
  sku: "bean_mandheling_03",
  price: 800,
  category: :consumable,
  available_count: 7
)

admin = User.new(
  email: ENV["ADMIN_EMAIL"] || "admin@gmail.com"
)

admin.password = "111111"
admin.save

product1.content.update!(body: ActionText::Content.new("<h1>★黃金曼特寧</h1><div><br></div><div>黃金曼特寧泛指蘇門達臘產區精緻栽培與加工的曼特寧，從萌芽生長、開花結果到生豆處理、烘培研磨及沖煮品嚐，每一個環節都影響咖啡豆的風味。在製程上，完全手工摘取，經過半水洗日晒乾燥後，再經四次人工篩選。</div><div><br></div><div>古典獨特的強烈口感與香氣，帶有濃郁的醇度和馥鬱而活潑的動感卻不酸澀，醇度、苦度可以表露無遺，品質堪稱世界之最，一度被專家認為是世界上最好的咖啡。</div><div><br></div><div>它有濃厚的口感以及像酒一般的醇度，並帶有濃烈野香，風味低沈老練，只有一點點酸性，餘韻深入喉嚨久久不去。</div>"))
product2.content.update!(body: ActionText::Content.new("<h1>★名字比較長一點的黃金曼特寧</h1><div><br></div><div>黃金曼特寧泛指蘇門達臘產區精緻栽培與加工的曼特寧，從萌芽生長、開花結果到生豆處理、烘培研磨及沖煮品嚐，每一個環節都影響咖啡豆的風味。在製程上，完全手工摘取，經過半水洗日晒乾燥後，再經四次人工篩選。</div><div><br></div><div>古典獨特的強烈口感與香氣，帶有濃郁的醇度和馥鬱而活潑的動感卻不酸澀，醇度、苦度可以表露無遺，品質堪稱世界之最，一度被專家認為是世界上最好的咖啡。</div><div><br></div><div>它有濃厚的口感以及像酒一般的醇度，並帶有濃烈野香，風味低沈老練，只有一點點酸性，餘韻深入喉嚨久久不去。</div>"))
product3.content.update!(body: ActionText::Content.new("<h1>★哇靠名字有夠長欸怎麼辦要換行欸的黃金曼特寧</h1><div><br></div><div>黃金曼特寧泛指蘇門達臘產區精緻栽培與加工的曼特寧，從萌芽生長、開花結果到生豆處理、烘培研磨及沖煮品嚐，每一個環節都影響咖啡豆的風味。在製程上，完全手工摘取，經過半水洗日晒乾燥後，再經四次人工篩選。</div><div><br></div><div>古典獨特的強烈口感與香氣，帶有濃郁的醇度和馥鬱而活潑的動感卻不酸澀，醇度、苦度可以表露無遺，品質堪稱世界之最，一度被專家認為是世界上最好的咖啡。</div><div><br></div><div>它有濃厚的口感以及像酒一般的醇度，並帶有濃烈野香，風味低沈老練，只有一點點酸性，餘韻深入喉嚨久久不去。</div>"))

regions = Psych.safe_load(File.read("db/seeds/shipping_regions.yml"))
regions = regions.map { |h|
  h[:id] = SecureRandom.uuid
  h.symbolize_keys
}
ShippingRegion.insert_all(regions)

default_region = ShippingRegion.find_by!(code: "TW")
provider = ShippingProvider.create!(
  name: "Harry Is Not Here Co., Ltd.",
  tax_id: "48770766", # randomly generated
  address: "Sec. 5, Nanjing E. Rd., Songshan Dist., Taipei City 105052 , Taiwan (R.O.C.)",
  email: "defintely-not-harry@gmail.com",
  contact_number: "(+886)02-1234567",
  region: default_region
)

[
  {name: "cvs_pickup_7_11", fee: 65},
  {name: "cvs_pay_pickup_7_11", fee: 70},
  {name: "cvs_pickup_ok", fee: 40},
  {name: "cvs_pay_pickup_ok", fee: 45},
  {name: "cvs_pickup_family_mart", fee: 60},
  {name: "cvs_pay_pickup_family_mart", fee: 65},
  {name: "cvs_pickup_hi_life", fee: 40},
  {name: "cvs_pay_pickup_hi_life", fee: 45},
  {
    name: "standard_shipping",
    fee: 80
  },
  {
    name: "expedited_shipping",
    fee: 150
  }
].each { |shipping_method| provider.shipping_methods.create!(shipping_method) }
