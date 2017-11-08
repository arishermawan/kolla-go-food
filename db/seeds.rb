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
    Best Tenderloin food in Jakarta, Delicious!!
    </p>},
  image_url:"tenderloin.jpg",
  price: 99000.00
  )


Food.create!(
  name: "Ayam Geprek",
  description:
  %{<p>
    ayam yang goreng yang digeprek
    </p>},
  image_url:"ayam_geprek.jpg",
  price: 15000.00
  )

Food.create!(
  name: "Tutug Oncom",
  description:
  %{<p>
    sundanese original food, mixed rice and oncom (permented soy bean), with chily and some vegetables, Maakkkyosss!!
    </p>},
  image_url:"tutug_oncom.jpg",
  price: 15000.00
  )

Food.create!(
  name: "Mie Goreng Golek",
  description:
  %{<p>
    Mie Goreng (Fried Noodle) Tek Tek is like Indonesian national street food. The fact that the sellers are using street cart and dragging the cart around all neighbourhoods while creating the noise to attract the potential dinner hunger customers (you don't definitely need to go to their cart, in fact they will approach your house gate and cook in front of your house) . The sellers are creating the noise by hitting the wok pan that sounds like "tag tag" or "tek tek" in Indonesian spelling. That's where the name tek tek comes from.</p>},
  image_url:"bakmi_golek.jpg",
  price: 18000.00
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
