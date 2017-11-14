
require 'rails_helper'

describe Order do

  it "is valid with a email, name, phone, and address" do
    expect(build(:buyer)).to be_valid
  end

  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "is valid with a name, address, email, and payment_type" do
    order = build(:order)
    expect(order).to be_valid
  end

  it "is invalid without a name" do
    order = build(:order, name: nil)
    order.valid?
    expect(order.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an address" do
    order = build(:order, address: nil)
    order.valid?
    expect(order.errors[:address]).to include("can't be blank")
  end

  it "is invalid without an email" do
    order = build(:order, email: nil)
    order.valid?
    expect(order.errors[:email]).to include("can't be blank")
  end

  it "is invalid with email not in valid email format" do
    order = build(:order, email: "cobacoba123")
    order.valid?
    expect(order.errors[:email]).to include("is invalid")
  end

  it "is invalid without a payment type" do
    order = build(:order, payment_type: nil)
    order.valid?
    expect(order.errors[:payment_type]).to include("can't be blank")
  end

  it "invalid with wrong payment_type" do
    expect{ build(:order, payment_type: "Grab Pay")}. to raise_error(ArgumentError)
  end

  describe "editing line_times from cart" do
    before :each do
      @cart = create(:cart)
      @line_item = create(:line_item, cart: @cart)
      @order = build(:order)
    end

    it "add line items to order" do
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

  it "is valid with a voucher" do
    order = build(:order, voucher_code: "10PERSEN")
    voucher = create(:voucher, code: "10PERSEN", valid_from:"2017-10-10", valid_through:"2017-11-20")
    expect(order).to be_valid
  end

  it "can calculate total order before discount" do
    order = create(:order)
    food1 = create(:food, price:10000)
    food2 = create(:food, price:15000)

    line_item1 = create(:line_item, order: order, food: food1, quantity:2)
    line_item2 = create(:line_item, order: order, food: food2, quantity:2)
    expect(order.sub_total).to eq(50000)
  end

  it "can calculate discount (rp)" do
    voucher = create(:voucher, code: "GOPAYAJA", unit_type: "Rp (Rupiah)", amount: 10000, max_amount:10000 )
    order = create(:order, voucher: voucher)
    food1 = create(:food, name:"nasi uduk", price:10000)
    food2 = create(:food, name:"nasi kuning", price:15000)

    line_item1 = create(:line_item, order: order, food: food1, quantity:2)
    line_item2 = create(:line_item, order: order, food: food2, quantity:2)
    expect(order.discount).to eq(10000)
  end

  it "can calculate discount (%)" do
    voucher = create(:voucher, code: "GOPAYAJA", unit_type: "% (Persentage)", amount: 10, max_amount:25000 )
    order = create(:order, voucher: voucher)
    food1 = create(:food, price:10000)
    food2 = create(:food, price:15000)

    line_item1 = create(:line_item, order: order, food: food1, quantity:2)
    line_item2 = create(:line_item, order: order, food: food2, quantity:2)
    expect(order.discount).to eq(5000)
  end

  it "can calculate max discount (%)" do
    voucher = create(:voucher, code: "GOPAYAJA", unit_type: "% (Persentage)", amount: 50, max_amount:25000 )
    order = create(:order, voucher: voucher)
    food1 = create(:food, price:10000)
    food2 = create(:food, price:15000)

    line_item1 = create(:line_item, order: order, food: food1, quantity:4)
    line_item2 = create(:line_item, order: order, food: food2, quantity:4)
    expect(order.discount).to eq(25000)
  end

  it "can calculate final price (rp)" do
    voucher = create(:voucher, code: "GOPAYAJA", unit_type: "Rp (Rupiah)", amount: 10000, max_amount:18000 )
    order = create(:order, voucher: voucher)
    food1 = create(:food, price:10000)
    food2 = create(:food, price:15000)

    line_item1 = create(:line_item, order: order, food: food1, quantity:2)
    line_item2 = create(:line_item, order: order, food: food2, quantity:2)
    expect(order.total_price).to eq(40000)
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
    order = build(:order, payment_type: "Go Pay", total: 50000, user: user)
    order.valid?
    expect(user.gopay).to eq(150000)
  end

end
