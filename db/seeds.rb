# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Food.delete_all

Food.create!(
  name: "Tenderloin Steak",
  description:
  %{<p>
    Best Tenderloin Steak in Jakarta, Delicious!!
    </p>},
  image_url:"tenderloin.jpg",
  price: 99000.00,
  category_id:2
  )


Food.create!(
  name: "Ayam Geprek",
  description:
  %{<p>
    Fried Chiked, mixed white traditional chily, so hot and very good taste!!!
    </p>},
  image_url:"ayam_geprek.jpg",
  price: 15000.00,
  category_id:1
  )

Food.create!(
  name: "Tutug Oncom",
  description:
  %{<p>
    sundanese original food, mixed rice and oncom (permented soy bean), with chily and some vegetables, Maakkkyosss!!
    </p>},
  image_url:"tutug_oncom.jpg",
  price: 15000.00,
  category_id:1
  )

Food.create!(
  name: "Mie Goreng Golek",
  description:
  %{<p>
    Mie Goreng (Fried Noodle) Tek Tek is like Indonesian national street food. The fact that the sellers are using street cart and dragging the cart around all neighbourhoods while creating the noise to attract the potential dinner hunger customers (you don't definitely need to go to their cart, in fact they will approach your house gate and cook in front of your house) . The sellers are creating the noise by hitting the wok pan that sounds like "tag tag" or "tek tek" in Indonesian spelling. That's where the name tek tek comes from.</p>},
  image_url:"bakmi_golek.jpg",
  price: 18000.00,
  category_id:1
  )

Buyer.delete_all

Buyer.create!(
  email: "arishermawan@hotmail.com",
  name:"aris hermawan",
  phone: "082310232303",
  address: "jln azalea raya no 3 lippo cikarang"
)

Buyer.create!(
  email: "i@arishermawan.id",
  name:"aris hermawan",
  phone: "082310232303",
  address: "jln azalea raya no 2 lippo cikarang"
)

Buyer.create!(
  email: "rizhima@gmail.com",
  name:"aris hermawan",
  phone: "082310232303",
  address: "jln azalea raya no 1 lippo cikarang"
)


Category.delete_all

Category.create!(
  name: 'Traditonal'
)

Category.create!(
  name: 'Modern Food'
)

Category.create!(
  name: 'Soft Drik'
)
Food::HABTM_Tags.create!([
  {food_id: 1, tag_id: 1},
  {food_id: 1, tag_id: 2},
  {food_id: 2, tag_id: 1},
  {food_id: 2, tag_id: 2},
  {food_id: 2, tag_id: 3},
  {food_id: 2, tag_id: 4},
  {food_id: 2, tag_id: 5},
  {food_id: 2, tag_id: 6},
  {food_id: 2, tag_id: 7},
  {food_id: 1, tag_id: 6},
  {food_id: 3, tag_id: 7},
  {food_id: 208, tag_id: 6},
  {food_id: 208, tag_id: 7},
  {food_id: 209, tag_id: 2},
  {food_id: 210, tag_id: 1},
  {food_id: 210, tag_id: 6},
  {food_id: 211, tag_id: 2},
  {food_id: 211, tag_id: 4},
  {food_id: 211, tag_id: 6},
  {food_id: 212, tag_id: 1},
  {food_id: 212, tag_id: 4},
  {food_id: 212, tag_id: 7}
])
Tag::HABTM_Foods.create!([
  {food_id: 1, tag_id: 1},
  {food_id: 1, tag_id: 2},
  {food_id: 2, tag_id: 1},
  {food_id: 2, tag_id: 2},
  {food_id: 2, tag_id: 3},
  {food_id: 2, tag_id: 4},
  {food_id: 2, tag_id: 5},
  {food_id: 2, tag_id: 6},
  {food_id: 2, tag_id: 7},
  {food_id: 1, tag_id: 6},
  {food_id: 3, tag_id: 7},
  {food_id: 208, tag_id: 6},
  {food_id: 208, tag_id: 7},
  {food_id: 209, tag_id: 2},
  {food_id: 210, tag_id: 1},
  {food_id: 210, tag_id: 6},
  {food_id: 211, tag_id: 2},
  {food_id: 211, tag_id: 4},
  {food_id: 211, tag_id: 6},
  {food_id: 212, tag_id: 1},
  {food_id: 212, tag_id: 4},
  {food_id: 212, tag_id: 7}
])
Buyer.create!([
  {email: "arishermawan@hotmail.com", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 3 lippo cikarang"},
  {email: "i@arishermawan.id", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 2 lippo cikarang"},
  {email: "rizhima@gmail.com", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 1 lippo cikarang"}
])
Cart.create!([
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {}
])
Category.create!([
  {name: "Traditonal"},
  {name: "Fast Food"},
  {name: "Soft Drik"}
])
Food.create!([
  {name: "Meat Steak", description: "<p>\r\n    daging terbaik dari sapi alami\r\n    </p>", image_url: "tenderloin.jpg", price: "99000.0", category_id: 2, restaurant_id: 2},
  {name: "Ayam Geprek", description: "<p>\r\n    ayam yang goreng yang digeprek \r\n    </p>", image_url: "ayam_geprek.jpg", price: "15000.0", category_id: 1, restaurant_id: 1},
  {name: "Tutug Oncom", description: "<p>\r\n    nasi diulek oncom dilengkapi sambal terasi dan timun \r\n    </p>", image_url: "tutug_oncom.jpg", price: "17000.0", category_id: 1, restaurant_id: 1},
  {name: "Bakmi Special", description: "<p>Bakmi Golek</p>", image_url: "bakmi_golek.jpg", price: "25000.0", category_id: 1, restaurant_id: 4},
  {name: "Keripik Maicih", description: "<p> keripik maicih </p>", image_url: "maicih.png", price: "16000.0", category_id: 2, restaurant_id: 6},
  {name: "Sukiyaki", description: "<p> Ramen from konoha </p>", image_url: "sukiyaki.jpg", price: "59000.0", category_id: 2, restaurant_id: 5},
  {name: "Udon", description: "<p>Ramen From Konoha</p>", image_url: "udon.jpg", price: "45000.0", category_id: 2, restaurant_id: 5},
  {name: "Ayam Geprek Komplit ", description: "<p> ayam geprek plus tahu tempe</p>", image_url: "ayam_geprek.jpg", price: "19000.0", category_id: 1, restaurant_id: 1}
])
LineItem.create!([
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 25},
  {food_id: 3, cart_id: nil, quantity: 2, order_id: 25},
  {food_id: 3, cart_id: nil, quantity: 2, order_id: 26},
  {food_id: 1, cart_id: nil, quantity: 3, order_id: 26},
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 27},
  {food_id: 3, cart_id: nil, quantity: 1, order_id: 27},
  {food_id: 208, cart_id: nil, quantity: 1, order_id: 27},
  {food_id: 211, cart_id: nil, quantity: 1, order_id: 27}
])
Order.create!([
  {name: "Aris Hermawan", address: "Sabang Jakarta", email: "a@ri.s", payment_type: "Go Pay", voucher_id: 3, total: "57600.0"},
  {name: "Budi Utomo", address: "Pondok Pinang, Jakarta", email: "b@u.i", payment_type: "Go Pay", voucher_id: 3, total: "311000.0"},
  {name: "aris herm", address: "jakarta", email: "arishermawan@hotmail.com", payment_type: "Cash", voucher_id: nil, total: "117000.0"}
])
Restaurant.create!([
  {name: "Bumbu Desa", address: "Sabang, Jakarta"},
  {name: "Bang Bang Steak", address: "Jl. Kebon Sirih No 7"},
  {name: "Bakmi Golek", address: "Sarinah Mall Lt 6"},
  {name: "Yashinoya", address: "Blok M Square Lt 6"},
  {name: "Wonder Juice Bar", address: "Paris van Java Bandung"}
])
Review.create!([
  {name: "aris", title: "Coba Coba bray", description: "jdfladf asklfjalkdf lksjflakjdflas flkasjdflj", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Fantastic!!!", description: "Restoran dengan menu klasik yang mantaps", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Mantap ", description: "Pedasnya mantaps", reviewable_type: "Food", reviewable_id: 2},
  {name: "Aris Hermawan", title: "Daging Empuk", description: "Dagingnya Empuk Bangetssssss", reviewable_type: "Food", reviewable_id: 1},
  {name: "Crystal Widjadja", title: "Unbreakable Taste!!", description: "Just 1 word 1 have to say to this Restaurant, Amazinggg!!!!!", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "dkjfald", description: "lkdsafjdlfjasldfjlsajflkdsjf", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "kljflads", title: "djflkasld", description: "dafldjfadslf", reviewable_type: "Food", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Mantap", description: "ok oko oko oko", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "ok", title: "ok", description: "ok", reviewable_type: "Restaurant", reviewable_id: 1}
])
Tag.create!([
  {name: "street food"},
  {name: "sweet spicy"},
  {name: "junkfood"},
  {name: "hotfood"},
  {name: "extremefood"},
  {name: "5 star"},
  {name: "indonesian original"}
])
User.create!([
  {username: "aris", password_digest: "$2a$10$m7JFjq34NfOg03fxMhcYSO6zaYloCUtEGyJ9VDmzhZI0vbYrdyhri"}
])
Voucher.create!([
  {code: "15PERSEN", valid_from: "2017-11-05", valid_through: "2017-11-15", amount: "15.0", unit_type: "% (Persentage)", max_amount: "30000.0"},
  {code: "NYOBAAJA", valid_from: "2017-11-05", valid_through: "2017-11-13", amount: "10000.0", unit_type: "Rp (Rupiah)", max_amount: "9000.0"},
  {code: "10PERSEN", valid_from: "2017-11-05", valid_through: "2017-11-13", amount: "10.0", unit_type: "% (Persentage)", max_amount: "20000.0"},
  {code: "GRATIS50K", valid_from: "2017-11-05", valid_through: "2017-11-05", amount: "50000.0", unit_type: "Rp (Rupiah)", max_amount: "50000.0"}
])
Food::HABTM_Tags.create!([
  {food_id: 1, tag_id: 1},
  {food_id: 1, tag_id: 2},
  {food_id: 2, tag_id: 1},
  {food_id: 2, tag_id: 2},
  {food_id: 2, tag_id: 3},
  {food_id: 2, tag_id: 4},
  {food_id: 2, tag_id: 5},
  {food_id: 2, tag_id: 6},
  {food_id: 2, tag_id: 7},
  {food_id: 1, tag_id: 6},
  {food_id: 3, tag_id: 7},
  {food_id: 208, tag_id: 6},
  {food_id: 208, tag_id: 7},
  {food_id: 209, tag_id: 2},
  {food_id: 210, tag_id: 1},
  {food_id: 210, tag_id: 6},
  {food_id: 211, tag_id: 2},
  {food_id: 211, tag_id: 4},
  {food_id: 211, tag_id: 6},
  {food_id: 212, tag_id: 1},
  {food_id: 212, tag_id: 4},
  {food_id: 212, tag_id: 7}
])
Tag::HABTM_Foods.create!([
  {food_id: 1, tag_id: 1},
  {food_id: 1, tag_id: 2},
  {food_id: 2, tag_id: 1},
  {food_id: 2, tag_id: 2},
  {food_id: 2, tag_id: 3},
  {food_id: 2, tag_id: 4},
  {food_id: 2, tag_id: 5},
  {food_id: 2, tag_id: 6},
  {food_id: 2, tag_id: 7},
  {food_id: 1, tag_id: 6},
  {food_id: 3, tag_id: 7},
  {food_id: 208, tag_id: 6},
  {food_id: 208, tag_id: 7},
  {food_id: 209, tag_id: 2},
  {food_id: 210, tag_id: 1},
  {food_id: 210, tag_id: 6},
  {food_id: 211, tag_id: 2},
  {food_id: 211, tag_id: 4},
  {food_id: 211, tag_id: 6},
  {food_id: 212, tag_id: 1},
  {food_id: 212, tag_id: 4},
  {food_id: 212, tag_id: 7}
])
Buyer.create!([
  {email: "arishermawan@hotmail.com", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 3 lippo cikarang"},
  {email: "i@arishermawan.id", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 2 lippo cikarang"},
  {email: "rizhima@gmail.com", name: "aris hermawan", phone: "082310232303", address: "jln azalea raya no 1 lippo cikarang"}
])
Cart.create!([
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {},
  {}
])
Category.create!([
  {name: "Traditonal"},
  {name: "Fast Food"},
  {name: "Soft Drik"}
])
Food.create!([
  {name: "Meat Steak", description: "<p>\r\n    daging terbaik dari sapi alami\r\n    </p>", image_url: "tenderloin.jpg", price: "99000.0", category_id: 2, restaurant_id: 2},
  {name: "Ayam Geprek", description: "<p>\r\n    ayam yang goreng yang digeprek \r\n    </p>", image_url: "ayam_geprek.jpg", price: "15000.0", category_id: 1, restaurant_id: 1},
  {name: "Tutug Oncom", description: "<p>\r\n    nasi diulek oncom dilengkapi sambal terasi dan timun \r\n    </p>", image_url: "tutug_oncom.jpg", price: "17000.0", category_id: 1, restaurant_id: 1},
  {name: "Bakmi Special", description: "<p>Bakmi Golek</p>", image_url: "bakmi_golek.jpg", price: "25000.0", category_id: 1, restaurant_id: 4},
  {name: "Keripik Maicih", description: "<p> keripik maicih </p>", image_url: "maicih.png", price: "16000.0", category_id: 2, restaurant_id: 6},
  {name: "Sukiyaki", description: "<p> Ramen from konoha </p>", image_url: "sukiyaki.jpg", price: "59000.0", category_id: 2, restaurant_id: 5},
  {name: "Udon", description: "<p>Ramen From Konoha</p>", image_url: "udon.jpg", price: "45000.0", category_id: 2, restaurant_id: 5},
  {name: "Ayam Geprek Komplit ", description: "<p> ayam geprek plus tahu tempe</p>", image_url: "ayam_geprek.jpg", price: "19000.0", category_id: 1, restaurant_id: 1}
])
LineItem.create!([
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 25},
  {food_id: 3, cart_id: nil, quantity: 2, order_id: 25},
  {food_id: 3, cart_id: nil, quantity: 2, order_id: 26},
  {food_id: 1, cart_id: nil, quantity: 3, order_id: 26},
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 27},
  {food_id: 3, cart_id: nil, quantity: 1, order_id: 27},
  {food_id: 208, cart_id: nil, quantity: 1, order_id: 27},
  {food_id: 211, cart_id: nil, quantity: 1, order_id: 27},
  {food_id: 208, cart_id: nil, quantity: 4, order_id: 28},
  {food_id: 210, cart_id: nil, quantity: 1, order_id: 28},
  {food_id: 211, cart_id: nil, quantity: 1, order_id: 28},
  {food_id: 2, cart_id: nil, quantity: 1, order_id: 28},
  {food_id: 3, cart_id: nil, quantity: 1, order_id: 28},
  {food_id: 212, cart_id: nil, quantity: 1, order_id: 28},
  {food_id: 209, cart_id: 47, quantity: 1, order_id: nil},
  {food_id: 2, cart_id: 47, quantity: 3, order_id: nil},
  {food_id: 2, cart_id: nil, quantity: 1, order_id: 29},
  {food_id: 208, cart_id: nil, quantity: 1, order_id: 29},
  {food_id: 209, cart_id: nil, quantity: 1, order_id: 29},
  {food_id: 3, cart_id: nil, quantity: 1, order_id: 30},
  {food_id: 1, cart_id: nil, quantity: 2, order_id: 31},
  {food_id: 212, cart_id: nil, quantity: 1, order_id: 32},
  {food_id: 211, cart_id: nil, quantity: 1, order_id: 33},
  {food_id: 210, cart_id: nil, quantity: 1, order_id: 33},
  {food_id: 209, cart_id: nil, quantity: 2, order_id: 34},
  {food_id: 208, cart_id: nil, quantity: 2, order_id: 35},
  {food_id: 209, cart_id: nil, quantity: 1, order_id: 36},
  {food_id: 2, cart_id: nil, quantity: 1, order_id: 37},
  {food_id: 3, cart_id: nil, quantity: 1, order_id: 38},
  {food_id: 1, cart_id: nil, quantity: 1, order_id: 39},
  {food_id: 211, cart_id: nil, quantity: 1, order_id: 40},
  {food_id: 209, cart_id: nil, quantity: 1, order_id: 41},
  {food_id: 210, cart_id: 62, quantity: 1, order_id: nil},
  {food_id: 210, cart_id: nil, quantity: 1, order_id: 42},
  {food_id: 208, cart_id: nil, quantity: 1, order_id: 43},
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 44},
  {food_id: 3, cart_id: nil, quantity: 3, order_id: 44},
  {food_id: 212, cart_id: nil, quantity: 3, order_id: 44},
  {food_id: 1, cart_id: nil, quantity: 2, order_id: 44},
  {food_id: 208, cart_id: nil, quantity: 1, order_id: 44},
  {food_id: 210, cart_id: nil, quantity: 1, order_id: 44},
  {food_id: 211, cart_id: nil, quantity: 2, order_id: 44},
  {food_id: 209, cart_id: nil, quantity: 1, order_id: 44},
  {food_id: 3, cart_id: nil, quantity: 2, order_id: 45},
  {food_id: 212, cart_id: nil, quantity: 2, order_id: 45},
  {food_id: 2, cart_id: nil, quantity: 2, order_id: 45}
])
Order.create!([
  {name: "Aris Hermawan", address: "Sabang Jakarta", email: "a@ri.s", payment_type: "Go Pay", voucher_id: 3, total: "57600.0"},
  {name: "Budi Utomo", address: "Pondok Pinang, Jakarta", email: "b@u.i", payment_type: "Go Pay", voucher_id: 3, total: "311000.0"},
  {name: "aris herm", address: "jakarta", email: "arishermawan@hotmail.com", payment_type: "Cash", voucher_id: nil, total: "117000.0"},
  {name: "Aris Hermawan", address: "Kebayoran lama", email: "arishermawan@hotmail.com", payment_type: "Credit Card", voucher_id: 3, total: "235000.0"},
  {name: "Rojali", address: "Sukawengi", email: "a@ri.s", payment_type: "Go Pay", voucher_id: 1, total: "47600.0"},
  {name: "Aris Hermawan", address: "sabang jakarata", email: "aku@net.id", payment_type: "Cash", voucher_id: nil, total: "17000.0"},
  {name: "naruto", address: "konohagakure", email: "na@ru.to", payment_type: "Go Pay", voucher_id: 3, total: "178200.0"},
  {name: "naruto", address: "konohagakure", email: "na@ru.to", payment_type: "Credit Card", voucher_id: nil, total: "19000.0"},
  {name: "naruto", address: "konohagakure", email: "na@ru.to", payment_type: "Go Pay", voucher_id: 1, total: "88400.0"},
  {name: "McGregor", address: "Portugis", email: "mc@gre.gor", payment_type: "Cash", voucher_id: nil, total: "32000.0"},
  {name: "Riou Mcdohl", address: "Roukhu", email: "a@ri.s", payment_type: "Cash", voucher_id: nil, total: "50000.0"},
  {name: "aris herm", address: "sukapulang", email: "aku@net.id", payment_type: "Go Pay", voucher_id: 3, total: "14400.0"},
  {name: "Rojali", address: "Ciledug", email: "ro@ja.li", payment_type: "Cash", voucher_id: 1, total: "12750.0"},
  {name: "McGregor", address: "Kebayoran Lama", email: "aku@net.id", payment_type: "Credit Card", voucher_id: nil, total: "17000.0"},
  {name: "Aris Hermawan", address: "sabanga", email: "arishermawan@hotmail.com", payment_type: "Cash", voucher_id: nil, total: "99000.0"},
  {name: "Aris Hermawan", address: "kebayoran baru", email: "arishermawan@hotmail.com", payment_type: "Go Pay", voucher_id: nil, total: "45000.0"},
  {name: "Aris Hermawan", address: "ciaming", email: "arishermawan@hotmail.com", payment_type: "Cash", voucher_id: nil, total: "16000.0"},
  {name: "Arisa", address: "belongsto", email: "a@ri.s", payment_type: "Credit Card", voucher_id: nil, total: "59000.0"},
  {name: "Rojali", address: "jajkarta", email: "ro@ja.li", payment_type: "Go Pay", voucher_id: nil, total: "25000.0"},
  {name: "McGregor", address: "The Pakubuwono Menteng", email: "a@ri.s", payment_type: "Credit Card", voucher_id: 1, total: "496000.0"},
  {name: "Aris Hermawan", address: "Tasikmalaya", email: "arishermawan@hotmail.com", payment_type: "Go Pay", voucher_id: nil, total: "102000.0"}
])
Restaurant.create!([
  {name: "Bumbu Desa", address: "Sabang, Jakarta"},
  {name: "Bang Bang Steak", address: "Jl. Kebon Sirih No 7"},
  {name: "Bakmi Golek", address: "Sarinah Mall Lt 6"},
  {name: "Yashinoya", address: "Blok M Square Lt 6"},
  {name: "Wonder Juice Bar", address: "Paris van Java Bandung"}
])
Review.create!([
  {name: "aris", title: "Coba Coba bray", description: "jdfladf asklfjalkdf lksjflakjdflas flkasjdflj", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Fantastic!!!", description: "Restoran dengan menu klasik yang mantaps", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Mantap ", description: "Pedasnya mantaps", reviewable_type: "Food", reviewable_id: 2},
  {name: "Aris Hermawan", title: "Daging Empuk", description: "Dagingnya Empuk Bangetssssss", reviewable_type: "Food", reviewable_id: 1},
  {name: "Crystal Widjadja", title: "Unbreakable Taste!!", description: "Just 1 word 1 have to say to this Restaurant, Amazinggg!!!!!", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "Aris Hermawan", title: "dkjfald", description: "lkdsafjdlfjasldfjlsajflkdsjf", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "kljflads", title: "djflkasld", description: "dafldjfadslf", reviewable_type: "Food", reviewable_id: 1},
  {name: "Aris Hermawan", title: "Mantap", description: "ok oko oko oko", reviewable_type: "Restaurant", reviewable_id: 1},
  {name: "ok", title: "ok", description: "ok", reviewable_type: "Restaurant", reviewable_id: 1}
])
Tag.create!([
  {name: "street food"},
  {name: "sweet spicy"},
  {name: "junkfood"},
  {name: "hotfood"},
  {name: "extremefood"},
  {name: "5 star"},
  {name: "indonesian original"}
])
User.create!([
  {username: "aris", password_digest: "$2a$10$m7JFjq34NfOg03fxMhcYSO6zaYloCUtEGyJ9VDmzhZI0vbYrdyhri"}
])
Voucher.create!([
  {code: "15PERSEN", valid_from: "2017-11-05", valid_through: "2017-11-15", amount: "15.0", unit_type: "% (Persentage)", max_amount: "30000.0"},
  {code: "NYOBAAJA", valid_from: "2017-11-05", valid_through: "2017-11-13", amount: "10000.0", unit_type: "Rp (Rupiah)", max_amount: "9000.0"},
  {code: "10PERSEN", valid_from: "2017-11-05", valid_through: "2017-11-13", amount: "10.0", unit_type: "% (Persentage)", max_amount: "20000.0"},
  {code: "GRATIS50K", valid_from: "2017-11-05", valid_through: "2017-11-05", amount: "50000.0", unit_type: "Rp (Rupiah)", max_amount: "50000.0"}
])
