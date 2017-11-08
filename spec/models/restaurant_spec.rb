require 'rails_helper'

describe Restaurant do

  it "is has a valid factory" do
    expect(build(:restaurant)).to be_valid
  end

  it "is valid with a name and address" do
    expect(build(:restaurant)).to be_valid
  end

  it "is invalid without a name" do
    restaurant = build(:restaurant, name: nil)
    restaurant.valid?
    expect(restaurant.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a address" do
    restaurant = build(:restaurant, address: nil)
    restaurant.valid?
    expect(restaurant.errors[:address]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    restaurant1 = create(:restaurant, name: "mcd")
    restaurant2 = build(:restaurant, name: "mcd")
    restaurant2.valid?
    expect(restaurant2.errors[:name]).to include("has already been taken")
  end

  it "can't be destroyed while it has foods(s)" do
    restaurant = create(:restaurant)
    food = create(:food, restaurant: restaurant)
    expect { restaurant.destroy }.not_to change(Restaurant, :count)
  end

end
