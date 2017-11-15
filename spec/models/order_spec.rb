
require 'rails_helper'

describe Order do
  include_context 'HTTP client'

  before(:example) do
    # stub_request(:get, /https:\/\/maps.googleapis.com\/maps\/api\/distancematrix\/.*/)
    #   .to_return(:status => 200, headers: { 'Content-Type' => 'application/json' }, body: '{"status":"OK","rows":[]}')

     # stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?avoid=tolls&destinations=sarinah,%20jakarta&key=AIzaSyAT3fcxh_TKujSW6d6fP9cUtrexk0eEvAE&language=en-AU&mode=driving&origins=kolla%20sabang,%20jakarta").
     #     with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'google-maps-services-ruby/0.4.2 Linux/4.10.0-38-generic'}).
     #     to_return(status: 200, body: "", headers: {})

     # expect(a_request(:get, 'https://maps.googleapis.com/maps/api/distancematrix/json?key=%s&origins=Perth%%2C+Australia%%7CSydney%%2C+Australia%%7CMelbourne%%2C+Australia%%7CAdelaide%%2C+Australia%%7CBrisbane%%2C+Australia%%7CDarwin%%2C+Australia%%7CHobart%%2C+Australia%%7CCanberra%%2C+Australia&destinations=Uluru%%2C+Australia%%7CKakadu%%2C+Australia%%7CBlue+Mountains%%2C+Australia%%7CBungle+Bungles%%2C+Australia%%7CThe+Pinnacles%%2C+Australia' % api_key))

     stub_request(:get, "https://maps.googleapis.com/maps/api/distancematrix/json?avoid=tolls&destinations=sarinah,%20jakarta&key=AIzaSyAT3fcxh_TKujSW6d6fP9cUtrexk0eEvAE&language=en-AU&mode=driving&origins=kolla%20sabang,%20jakarta")

  end

  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "is valid with a name, address, email, and payment_type" do
    expect(build(:order)).to be_valid
  end

  it "is invalid without a name" do
    order = build(:order, name: nil)
    order.valid?
    expect(order.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an address" do
    order = build(:order, address: "")
    order.valid?
    expect(order.errors[:address]).to include("can't be blank")
  end

  it "is invalid without an email" do
    order = build(:order, email: nil)
    order.valid?
    expect(order.errors[:email]).to include("can't be blank")
  end

  it "is invalid with email not in valid email format" do
    order = build(:order, email: "email")
    order.valid?
    expect(order.errors[:email]).to include("is invalid")
  end

  it "is invalid without a payment_type" do
    order = build(:order, payment_type: nil)
    order.valid?
    expect(order.errors[:payment_type]).to include("can't be blank")
  end

  it "is invalid with wrong payment_type" do
    expect{ build(:order, payment_type: "Grab Pay") }.to raise_error(ArgumentError)
  end

  describe "adding line_items from cart" do
    before :each do
      @cart = create(:cart)
      @line_item = create(:line_item, cart: @cart)
      @order = build(:order)
    end

    it "add line_items to order" do
      expect{
        @order.add_line_items(@cart)
        @order.save
      }.to change(@order.line_items, :count).by(1)
    end

    it "removes line_items from cart" do
      expect{
        @order.add_line_items(@cart)
        @order.save
      }.to change(@cart.line_items, :count).by(-1)
    end
  end

  describe "adding discount to order" do
    context "with valid voucher" do
      before :each do
        @voucher = create(:voucher, code: 'VOUCHER1', amount: 15.0, unit_type: "% (Persentage)", max_amount: 10000)
        @cart = create(:cart)
        @food = create(:food, price: 100000.0)
        @line_item = create(:line_item, quantity: 1, food: @food, cart: @cart)
        @order = create(:order, voucher: @voucher)
        @order.add_line_items(@cart)
      end

      it "can calculate sub total price" do
        @order.save
        expect(@order.sub_total).to eq(100000)
      end

      context "with voucher in percent" do
        it "can calculate discount" do
          voucher = create(:voucher, code: 'VOUCHER2', amount: 5, unit_type: "% (Persentage)", max_amount: 10000)
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          order.save
          expect(order.discount).to eq(5000)
        end

        it "changes discount to max_amount if discount is bigger than max_amount" do
          @order.save
          expect(@order.discount).to eq(10000)
        end
      end

      context "with voucher in rupiah" do
        it "can calculate discount" do
          voucher = create(:voucher, amount: 5000, unit_type: "Rp (Rupiah)", max_amount: 10000)
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          order.save
          expect(order.discount).to eq(5000)
        end
      end

      it "can calculate total price" do
        @order.save
        expect(@order.total_price).to eq(90000)
      end
    end

    context "with invalid voucher" do
      it "is invalid with a wrong voucher" do
        order = build(:order, voucher_code: "okokok")
        order.valid?
        expect(order.errors[:voucher_code]).to include("is not exist")
      end

      it "is invalid with an expire voucher" do
        order = build(:order, voucher_code: "10PERSEN")
        voucher = create(:voucher, code: "10PERSEN", valid_from:"2015-10-10", valid_through:"2015-10-11")
        order.valid?
        expect(order.errors[:voucher_code]).to include("is expire")
      end
    end
  end

  it "save user to order's user_id" do
    user = create(:user)
    order = create(:order, user: user)
    expect(order.user_id).to eq(user.id)
  end

  it "is invalid if gopay credit less than total price of order" do
    user = create(:user)
    order = build(:order, payment_type: "Go Pay", total: 300000, user: user)
    order.valid?
    expect(order.errors[:payment_type]).to include("Gopay credit is not enough")
  end

  it "is reduce the gopay credit" do
    user = create(:user)
    order = create(:order, payment_type: "Go Pay", total: 50000, user: user)
    expect(order.reduce_gopay).to eq(150000)
  end

  # describe "adding google maps apis service" do
  #   before :each do
  #     @restaurant = create(:restaurant, address: "kolla sabang, jakarta")
  #     @order = build(:order, address: "sarinah, jakarta")
  #     @food = create(:food, restaurant: @restaurant)
  #     @line_item = create(:line_item, food:@food, order:@order)
  #   end
  #   it "calculate distance from origin and destination" do
  #     expect(@order.distance).to eq(325)
  #   end

  #   it "calculate delivary cost from distance" do
  #     expect(@order.delivery_cost).to eq(487.5)
  #   end

  # end

end

  # it "is invalid with a wrong voucher" do
  #   order = build(:order, voucher_code: "okokok")
  #   order.valid?
  #   expect(order.errors[:voucher_code]).to include("is not exist")
  # end

  # it "is invalid with an expire voucher" do
  #   order = build(:order, voucher_code: "10PERSEN")
  #   voucher = create(:voucher, code: "10PERSEN", valid_from:"2015-10-10", valid_through:"2015-10-11")
  #   order.valid?
  #   expect(order.errors[:voucher_code]).to include("is expire")
  # end

#   it "is valid with a voucher" do
#     order = build(:order, voucher_code: "10PERSEN")
#     voucher = create(:voucher, code: "10PERSEN", valid_from:"2017-10-10", valid_through:"2017-11-20")
#     expect(order).to be_valid
#   end

#   it "can calculate total order before discount" do
#     order = create(:order)
#     food1 = create(:food, price:10000)
#     food2 = create(:food, price:15000)

#     line_item1 = create(:line_item, order: order, food: food1, quantity:2)
#     line_item2 = create(:line_item, order: order, food: food2, quantity:2)
#     expect(order.sub_total).to eq(50000)
#   end

#   it "can calculate discount (rp)" do
#     voucher = create(:voucher, code: "GOPAYAJA", unit_type: "Rp (Rupiah)", amount: 10000, max_amount:10000 )
#     order = create(:order, voucher: voucher)
#     food1 = create(:food, name:"nasi uduk", price:10000)
#     food2 = create(:food, name:"nasi kuning", price:15000)

#     line_item1 = create(:line_item, order: order, food: food1, quantity:2)
#     line_item2 = create(:line_item, order: order, food: food2, quantity:2)
#     expect(order.discount).to eq(10000)
#   end

#   it "can calculate discount (%)" do
#     voucher = create(:voucher, code: "GOPAYAJA", unit_type: "% (Persentage)", amount: 10, max_amount:25000 )
#     order = create(:order, voucher: voucher)
#     food1 = create(:food, price:10000)
#     food2 = create(:food, price:15000)

#     line_item1 = create(:line_item, order: order, food: food1, quantity:2)
#     line_item2 = create(:line_item, order: order, food: food2, quantity:2)
#     expect(order.discount).to eq(5000)
#   end

#   it "can calculate max discount (%)" do
#     voucher = create(:voucher, code: "GOPAYAJA", unit_type: "% (Persentage)", amount: 50, max_amount:25000 )
#     order = create(:order, voucher: voucher)
#     food1 = create(:food, price:10000)
#     food2 = create(:food, price:15000)

#     line_item1 = create(:line_item, order: order, food: food1, quantity:4)
#     line_item2 = create(:line_item, order: order, food: food2, quantity:4)
#     expect(order.discount).to eq(25000)
#   end

#   it "can calculate final price (rp)" do
#     voucher = create(:voucher, code: "GOPAYAJA", unit_type: "Rp (Rupiah)", amount: 10000, max_amount:18000 )
#     order = create(:order, voucher: voucher)
#     food1 = create(:food, price:10000)
#     food2 = create(:food, price:15000)

#     line_item1 = create(:line_item, order: order, food: food1, quantity:2)
#     line_item2 = create(:line_item, order: order, food: food2, quantity:2)
#     expect(order.total_price).to eq(40000)
#   end

#   it "save user to order's user_id" do
#     user = create(:user)
#     order = create(:order, user: user)
#     expect(order.user_id).to eq(user.id)
#   end

#   it "is invalid if gopay credit less than total price of order" do
#     user = create(:user)
#     order = build(:order, payment_type: "Go Pay", total: 300000, user: user)
#     order.valid?
#     expect(order.errors[:payment_type]).to include("Gopay credit is not enough")
#   end

#   it "is reduce the gopay credit" do
#     user = create(:user)
#     order = create(:order, payment_type: "Go Pay", total: 50000, user: user)
#     expect(order.reduce_gopay).to eq(150000)
#   end

#   describe "adding google maps apis service" do
#     before :each do
#       @restaurant = create(:restaurant, address: "kolla sabang, jakarta")
#       @order = build(:order, address: "sarinah, jakarta")
#       @food = create(:food, restaurant: @restaurant)
#       @line_item = create(:line_item, food:@food, order:@order)
#     end
#     it "calculate distance from origin and destination" do
#       expect(@order.distance).to eq(325)
#     end

#     it "calculate delivary cost from distance" do
#       expect(@order.delivery_cost).to eq(487,5)
#     end

#   end

# end
