require 'rails_helper'

describe Drink do

  it "is valid with a name and description" do
    expect(build(:drink)).to be_valid
  end

  it "is invalid without a name" do
    drink = build(:drink, name: nil)
    drink.valid?
    expect(drink.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    drink = build(:drink, description: nil)
    drink.valid?
    expect(drink.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    drink1 = create(:drink, name: "juicy")
    drink2 = build(:drink, name: "juicy")
    drink2.valid?
    expect(drink2.errors[:name]).to include("has already been taken")
  end

  it "is invalid if price less than 0.01" do
  end

  it "is invalid if image url string end with anything other than \".gif\", \".jpg\" or\".png\", " do
  end

  describe "price must be numeric" do
    before :each do
    end

    context "with numeric input price" do
      it "is valid price numeric" do
      end
    end

    context "with non numeric input price" do
      it "is invalid price numeric" do
      end
    end
  end

  describe "returns a sorted array of results that match" do
    before :each do
    end

    context "it macthing letters" do
      it "returns a sorted array of results that match" do
      end
    end

    context "with non matching letters do" do
      it "omits results that do not match" do
      end
    end
  end

end