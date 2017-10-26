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
    daging terbaik dari sapi alami
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
    nasi diulek oncom dilengkapi sambal terasi dan timun 
    </p>},
  image_url:"tutug_oncom.jpg",
  price: 17000.00
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




