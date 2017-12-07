
require 'rails_helper'

describe Order do

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
      @restaurant = create(:restaurant, address:"kolla sabang, jakarta")
      @food = create(:food, restaurant: @restaurant)
      @line_item = create(:line_item, food:@food, cart: @cart)
      @order = build(:order)
    end

    it "add line_items to order" do
        @order.add_line_items(@cart)
        @order.save
       expect(@order.line_items.size).to eq(1)
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
        @restaurant = create(:restaurant, address: "kolla sabang, jakarta")
        @food = create(:food, price: 100000.0, restaurant: @restaurant)
        @line_item = create(:line_item, quantity: 1, food: @food, cart: @cart)
        @order = create(:order, voucher: @voucher, address: "sarinah, jakarta")
        @order.add_line_items(@cart)
      end

      it "can calculate sub total price" do
        @order.save
        expect(@order.sub_total).to eq(100000)
      end

      it "can calculate sub total + delivery_cost" do
        @order.save
        expect(@order.sub_total_delivery).to eq(100488)
      end

      context "with voucher in percent" do
        it "can calculate discount" do
          voucher = create(:voucher, code: 'VOUCHER2', amount: 5, unit_type: "% (Persentage)", max_amount: 10000)
          order = create(:order, voucher: voucher)
          order.add_line_items(@cart)
          order.save
          expect(order.discount).to eq(5024)
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
        expect(@order.total_price).to eq(90488)
      end
    end


    it "is invalid with a wrong voucher" do
      order = build(:order, voucher_code: "okokok")
      order.valid?
      expect(order.errors[:voucher_code]).to include("is not exist")
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

  # it "is reduce the gopay credit" do
  #   user = create(:user)
  #   order = create(:order, payment_type: "Go Pay", total: 50000, user: user)
  #   order.reduce_gopay
  #   user.reload
  #   expect(user.gopay).to eq(150000)
  # end

  describe "adding google maps apis service" do
    before :each do
      @cart = create(:cart)
      @restaurant = create(:restaurant, address: "kolla sabang, jakarta")
      @food = create(:food, restaurant: @restaurant)
      @line_item = create(:line_item, food:@food, cart:@cart)
      @order = build(:order, address: "sarinah, jakarta")
      @order.add_line_items(@cart)
    end

    it "get json data from google api" do
      expect(@order.get_google_api).not_to eq(nil)
    end

    it "calculate distance from origin and destination" do
      expect(@order.distance).to eq(325)
    end

    it "calculate delivary cost from distance" do
      expect(@order.delivery_cost).to eq(488)
    end
  end
end
