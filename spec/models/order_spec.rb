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

end